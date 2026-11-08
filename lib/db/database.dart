import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

enum Estado {
  recibida('Recibida'),
  enDiagnostico('En diagnóstico'),
  enReparacion('En reparación'),
  listaParaEntregar('Lista para entregar'),
  entregada('Entregada'),
  cancelada('Cancelada');

  const Estado(this.label);
  final String label;
  bool get abierta => this != entregada && this != cancelada;
}

/// Error de regla de negocio: la UI muestra [msg] al usuario.
class AppError implements Exception {
  final String msg;
  AppError(this.msg);
}

class Clientes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100)();
  TextColumn get telefono => text()();
  TextColumn get direccion => text().nullable()();
}

class Vehiculos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clienteId => integer().references(Clientes, #id)();
  TextColumn get matricula => text().unique()();
  TextColumn get marca => text()();
  TextColumn get modelo => text()();
  IntColumn get anio => integer()();
  IntColumn get km => integer()(); // km de la última visita
}

class Mecanicos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
}

@DataClassName('Orden')
class Ordenes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehiculoId => integer().references(Vehiculos, #id)();
  IntColumn get mecanicoId => integer().references(Mecanicos, #id)();
  DateTimeColumn get fechaEntrada => dateTime()();
  TextColumn get problema => text()();
  TextColumn get estado => textEnum<Estado>()();
  IntColumn get kmIngreso => integer()();
}

class Trabajos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId => integer().references(Ordenes, #id)();
  TextColumn get descripcion => text()();
  RealColumn get precio => real()(); // mano de obra
}

class Repuestos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get codigo => text().unique()();
  RealColumn get precio => real()();
  IntColumn get existencias => integer().check(existencias.isBiggerOrEqualValue(0))();
  IntColumn get stockMinimo => integer().withDefault(const Constant(3))();
}

class OrdenRepuestos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId => integer().references(Ordenes, #id)();
  IntColumn get repuestoId => integer().references(Repuestos, #id)();
  IntColumn get cantidad => integer()();
  RealColumn get precioUnitario => real()(); // precio al momento de usarlo
}

class Pagos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId => integer().references(Ordenes, #id)();
  RealColumn get monto => real()();
  DateTimeColumn get fecha => dateTime()();
}

/// Vista de una orden con sus datos relacionados y totales calculados.
class OrdenResumen {
  final int id, vehiculoId, clienteId, mecanicoId;
  final Estado estado;
  final DateTime fecha;
  final String problema, matricula, vehiculo, cliente, mecanico;
  final double total, pagado;

  const OrdenResumen({
    required this.id,
    required this.vehiculoId,
    required this.clienteId,
    required this.mecanicoId,
    required this.estado,
    required this.fecha,
    required this.problema,
    required this.matricula,
    required this.vehiculo,
    required this.cliente,
    required this.mecanico,
    required this.total,
    required this.pagado,
  });

  double get saldo => total - pagado;

  factory OrdenResumen.fromRow(QueryRow r) => OrdenResumen(
        id: r.read<int>('id'),
        vehiculoId: r.read<int>('vehiculo_id'),
        clienteId: r.read<int>('cliente_id'),
        mecanicoId: r.read<int>('mecanico_id'),
        estado: Estado.values.byName(r.read<String>('estado')),
        fecha: r.read<DateTime>('fecha_entrada'),
        problema: r.read<String>('problema'),
        matricula: r.read<String>('matricula'),
        vehiculo: '${r.read<String>('marca')} ${r.read<String>('modelo')}',
        cliente: r.read<String>('cliente'),
        mecanico: r.read<String>('mecanico'),
        total: (r.data['total'] as num).toDouble(),
        pagado: (r.data['pagado'] as num).toDouble(),
      );
}

@DriftDatabase(tables: [Clientes, Vehiculos, Mecanicos, Ordenes, Trabajos, Repuestos, OrdenRepuestos, Pagos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'el_piston'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await into(mecanicos).insert(MecanicosCompanion.insert(nombre: 'Mecánico 1'));
          await into(mecanicos).insert(MecanicosCompanion.insert(nombre: 'Mecánico 2'));
        },
        beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
      );

  // ───────────── Órdenes (consulta con totales) ─────────────
  static const _sql = '''
SELECT o.id, o.vehiculo_id, o.mecanico_id, o.fecha_entrada, o.problema, o.estado,
  v.matricula, v.marca, v.modelo, c.id AS cliente_id, c.nombre AS cliente, m.nombre AS mecanico,
  COALESCE((SELECT SUM(precio) FROM trabajos WHERE orden_id = o.id), 0)
  + COALESCE((SELECT SUM(cantidad * precio_unitario) FROM orden_repuestos WHERE orden_id = o.id), 0) AS total,
  COALESCE((SELECT SUM(monto) FROM pagos WHERE orden_id = o.id), 0) AS pagado
FROM ordenes o
JOIN vehiculos v ON v.id = o.vehiculo_id
JOIN clientes c ON c.id = v.cliente_id
JOIN mecanicos m ON m.id = o.mecanico_id''';

  Selectable<OrdenResumen> _resumenes({int? ordenId, int? vehiculoId, int? clienteId}) {
    final w = <String>[];
    final vars = <Variable>[];
    if (ordenId != null) { w.add('o.id = ?'); vars.add(Variable.withInt(ordenId)); }
    if (vehiculoId != null) { w.add('o.vehiculo_id = ?'); vars.add(Variable.withInt(vehiculoId)); }
    if (clienteId != null) { w.add('c.id = ?'); vars.add(Variable.withInt(clienteId)); }
    return customSelect(
      '$_sql ${w.isEmpty ? '' : 'WHERE ${w.join(' AND ')}'} ORDER BY o.fecha_entrada DESC, o.id DESC',
      variables: vars,
      readsFrom: {ordenes, vehiculos, clientes, mecanicos, trabajos, ordenRepuestos, pagos},
    ).map(OrdenResumen.fromRow);
  }

  Stream<List<OrdenResumen>> watchResumenes({int? ordenId, int? vehiculoId, int? clienteId}) =>
      _resumenes(ordenId: ordenId, vehiculoId: vehiculoId, clienteId: clienteId).watch();

  Future<Orden> _orden(int id) => (select(ordenes)..where((t) => t.id.equals(id))).getSingle();

  Future<void> _exigirAbierta(int ordenId) async {
    if (!(await _orden(ordenId)).estado.abierta) throw AppError('La orden está cerrada');
  }

  Future<void> _ajustarStock(int repuestoId, int delta) => customUpdate(
        'UPDATE repuestos SET existencias = existencias + ? WHERE id = ?',
        variables: [Variable.withInt(delta), Variable.withInt(repuestoId)],
        updates: {repuestos},
      );

  Future<void> crearOrden({
    required int vehiculoId,
    required int mecanicoId,
    required String problema,
    required int km,
  }) =>
      transaction(() async {
        await into(ordenes).insert(OrdenesCompanion.insert(
          vehiculoId: vehiculoId,
          mecanicoId: mecanicoId,
          fechaEntrada: DateTime.now(),
          problema: problema,
          estado: Estado.recibida,
          kmIngreso: km,
        ));
        await (update(vehiculos)..where((v) => v.id.equals(vehiculoId)))
            .write(VehiculosCompanion(km: Value(km)));
      });

  Future<void> cambiarEstado(int id, Estado nuevo) => transaction(() async {
        await _exigirAbierta(id);
        if (nuevo == Estado.cancelada) {
          // Al cancelar, los repuestos vuelven al inventario.
          final usados = await (select(ordenRepuestos)..where((t) => t.ordenId.equals(id))).get();
          for (final u in usados) {
            await _ajustarStock(u.repuestoId, u.cantidad);
          }
        }
        await (update(ordenes)..where((t) => t.id.equals(id))).write(OrdenesCompanion(estado: Value(nuevo)));
      });

  // ───────────── Trabajos, repuestos usados y pagos ─────────────
  Stream<List<Trabajo>> watchTrabajos(int ordenId) =>
      (select(trabajos)..where((t) => t.ordenId.equals(ordenId))).watch();

  Future<void> agregarTrabajo(int ordenId, String descripcion, double precio) => transaction(() async {
        await _exigirAbierta(ordenId);
        await into(trabajos).insert(TrabajosCompanion.insert(ordenId: ordenId, descripcion: descripcion, precio: precio));
      });

  Future<void> quitarTrabajo(int id) => transaction(() async {
        final t = await (select(trabajos)..where((x) => x.id.equals(id))).getSingle();
        await _exigirAbierta(t.ordenId);
        await (delete(trabajos)..where((x) => x.id.equals(id))).go();
      });

  Stream<List<TypedResult>> watchRepuestosDeOrden(int ordenId) => (select(ordenRepuestos).join([
        innerJoin(repuestos, repuestos.id.equalsExp(ordenRepuestos.repuestoId)),
      ])..where(ordenRepuestos.ordenId.equals(ordenId)))
          .watch();

  /// Descuenta stock y registra el uso. Devuelve un aviso si el stock queda bajo.
  Future<String?> usarRepuesto(int ordenId, int repuestoId, int cantidad) => transaction<String?>(() async {
        await _exigirAbierta(ordenId);
        if (cantidad <= 0) throw AppError('Cantidad inválida');
        final r = await (select(repuestos)..where((t) => t.id.equals(repuestoId))).getSingle();
        if (r.existencias < cantidad) throw AppError('Solo quedan ${r.existencias} de ${r.nombre}');
        await _ajustarStock(repuestoId, -cantidad);
        await into(ordenRepuestos).insert(OrdenRepuestosCompanion.insert(
          ordenId: ordenId,
          repuestoId: repuestoId,
          cantidad: cantidad,
          precioUnitario: r.precio,
        ));
        final resto = r.existencias - cantidad;
        return resto <= r.stockMinimo ? '⚠ Stock bajo: quedan $resto de ${r.nombre}' : null;
      });

  Future<void> quitarRepuesto(OrdenRepuesto u) => transaction(() async {
        await _exigirAbierta(u.ordenId);
        await _ajustarStock(u.repuestoId, u.cantidad);
        await (delete(ordenRepuestos)..where((x) => x.id.equals(u.id))).go();
      });

  Stream<List<Pago>> watchPagos(int ordenId) =>
      (select(pagos)..where((t) => t.ordenId.equals(ordenId))..orderBy([(t) => OrderingTerm.desc(t.fecha)])).watch();

  Future<void> registrarPago(int ordenId, double monto) => transaction(() async {
        final o = await _orden(ordenId);
        if (o.estado == Estado.cancelada) throw AppError('La orden está cancelada');
        if (monto <= 0) throw AppError('Monto inválido');
        final saldo = (await _resumenes(ordenId: ordenId).getSingle()).saldo;
        if (monto > saldo + 0.005) throw AppError('El pago supera el saldo (${saldo.toStringAsFixed(2)})');
        await into(pagos).insert(PagosCompanion.insert(ordenId: ordenId, monto: monto, fecha: DateTime.now()));
      });

  // ───────────── Clientes y vehículos ─────────────
  Stream<List<Cliente>> watchClientes() =>
      (select(clientes)..orderBy([(c) => OrderingTerm.asc(c.nombre)])).watch();
  Stream<Cliente> watchCliente(int id) => (select(clientes)..where((c) => c.id.equals(id))).watchSingle();

  Future<void> guardarCliente({int? id, required String nombre, required String telefono, String? direccion}) =>
      into(clientes).insertOnConflictUpdate(ClientesCompanion(
        id: id == null ? const Value.absent() : Value(id),
        nombre: Value(nombre),
        telefono: Value(telefono),
        direccion: Value(direccion),
      ));

  Stream<List<Vehiculo>> watchVehiculosDe(int clienteId) =>
      (select(vehiculos)..where((v) => v.clienteId.equals(clienteId))).watch();
  Stream<Vehiculo> watchVehiculo(int id) => (select(vehiculos)..where((v) => v.id.equals(id))).watchSingle();

  Future<List<(Vehiculo, Cliente)>> vehiculosConCliente() async {
    final q = select(vehiculos).join([innerJoin(clientes, clientes.id.equalsExp(vehiculos.clienteId))])
      ..orderBy([OrderingTerm.asc(vehiculos.matricula)]);
    return [for (final r in await q.get()) (r.readTable(vehiculos), r.readTable(clientes))];
  }

  Future<void> guardarVehiculo({
    int? id,
    required int clienteId,
    required String matricula,
    required String marca,
    required String modelo,
    required int anio,
    required int km,
  }) async {
    final m = matricula.toUpperCase();
    final dup = await (select(vehiculos)..where((v) => v.matricula.equals(m))).getSingleOrNull();
    if (dup != null && dup.id != id) throw AppError('Ya existe un vehículo con la matrícula $m');
    await into(vehiculos).insertOnConflictUpdate(VehiculosCompanion(
      id: id == null ? const Value.absent() : Value(id),
      clienteId: Value(clienteId),
      matricula: Value(m),
      marca: Value(marca),
      modelo: Value(modelo),
      anio: Value(anio),
      km: Value(km),
    ));
  }

  // ───────────── Mecánicos ─────────────
  Stream<List<Mecanico>> watchMecanicos() => select(mecanicos).watch();
  Future<List<Mecanico>> listaMecanicos() => select(mecanicos).get();
  Future<void> renombrarMecanico(int id, String nombre) =>
      (update(mecanicos)..where((m) => m.id.equals(id))).write(MecanicosCompanion(nombre: Value(nombre)));

  // ───────────── Inventario ─────────────
  Stream<List<Repuesto>> watchRepuestos() =>
      (select(repuestos)..orderBy([(r) => OrderingTerm.asc(r.nombre)])).watch();
  Future<List<Repuesto>> listaRepuestos() => (select(repuestos)..orderBy([(r) => OrderingTerm.asc(r.nombre)])).get();

  Stream<List<Repuesto>> watchStockBajo() => (select(repuestos)
        ..where((r) => r.existencias.isSmallerOrEqual(r.stockMinimo))
        ..orderBy([(r) => OrderingTerm.asc(r.existencias)]))
      .watch();

  Future<void> guardarRepuesto({
    int? id,
    required String nombre,
    required String codigo,
    required double precio,
    required int existencias,
    required int stockMinimo,
  }) async {
    final dup = await (select(repuestos)..where((r) => r.codigo.equals(codigo))).getSingleOrNull();
    if (dup != null && dup.id != id) throw AppError('Ya existe un repuesto con el código $codigo');
    await into(repuestos).insertOnConflictUpdate(RepuestosCompanion(
      id: id == null ? const Value.absent() : Value(id),
      nombre: Value(nombre),
      codigo: Value(codigo),
      precio: Value(precio),
      existencias: Value(existencias),
      stockMinimo: Value(stockMinimo),
    ));
  }

  Future<void> reponer(int id, int cantidad) async {
    if (cantidad <= 0) throw AppError('Cantidad inválida');
    await _ajustarStock(id, cantidad);
  }
}
