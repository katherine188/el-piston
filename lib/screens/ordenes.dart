import 'package:drift/drift.dart' show TypedResult;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/database.dart';
import '../ui.dart';

/// Flujo de nueva orden. Si [vehiculo] es null, se pide elegirlo.
Future<void> nuevaOrden(BuildContext context, {Vehiculo? vehiculo}) async {
  final db = context.read<AppDatabase>();
  Vehiculo? veh = vehiculo;
  if (veh == null) {
    final lista = await db.vehiculosConCliente();
    if (!context.mounted) return;
    if (lista.isEmpty) {
      aviso(context, 'Primero registra un cliente y su vehículo');
      return;
    }
    final sel = await pick<(Vehiculo, Cliente)>(
        context, 'Vehículo', lista, (e) => '${e.$1.matricula} · ${e.$1.marca} ${e.$1.modelo} (${e.$2.nombre})');
    if (sel == null) return;
    veh = sel.$1;
  }
  final Vehiculo vv = veh;
  final mecs = await db.listaMecanicos();
  if (!context.mounted) return;
  final m = await pick<Mecanico>(context, 'Asignar a', mecs, (m) => m.nombre);
  if (m == null || !context.mounted) return;
  final r = await formDialog(context, 'Nueva orden · ${vv.matricula}', [
    const Field('Problema reportado'),
    Field('Kilometraje actual', kind: Kind.int, initial: '${vv.km}'),
  ]);
  if (r == null || !context.mounted) return;
  await run(context, () => db.crearOrden(vehiculoId: vv.id, mecanicoId: m.id, problema: r[0], km: int.parse(r[1])));
}

class OrdenTile extends StatelessWidget {
  final OrdenResumen o;
  const OrdenTile(this.o, {super.key});

  @override
  Widget build(BuildContext context) {
    final debe = o.estado != Estado.cancelada && o.saldo > 0.005;
    return ListTile(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrdenDetalle(o.id))),
      title: Text('#${o.id} · ${o.matricula} · ${o.vehiculo}'),
      subtitle: Text('${o.cliente} · ${o.mecanico}\n${fecha(o.fecha)}${debe ? ' · Debe ${money(o.saldo)}' : ''}'),
      isThreeLine: true,
      trailing: EstadoChip(o.estado),
    );
  }
}

class OrdenesTab extends StatefulWidget {
  const OrdenesTab({super.key});
  @override
  State<OrdenesTab> createState() => _OrdenesTabState();
}

class _OrdenesTabState extends State<OrdenesTab> {
  static final _filtros = <(String, bool Function(OrdenResumen))>[
    ('Abiertas', (OrdenResumen o) => o.estado.abierta),
    ('Todas', (OrdenResumen o) => true),
    for (final e in Estado.values) (e.label, (OrdenResumen o) => o.estado == e),
  ];
  int _f = 0;
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return Scaffold(
      appBar: AppBar(title: const Text('Órdenes de servicio')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => nuevaOrden(context),
        icon: const Icon(Icons.add),
        label: const Text('Nueva orden'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Matrícula, cliente o mecánico', border: OutlineInputBorder()),
            onChanged: (v) => setState(() => _q = v.toLowerCase()),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            for (var i = 0; i < _filtros.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(label: Text(_filtros[i].$1), selected: _f == i, onSelected: (_) => setState(() => _f = i)),
              ),
          ]),
        ),
        Expanded(
          child: StreamBuilder<List<OrdenResumen>>(
            stream: db.watchResumenes(),
            builder: (c, s) {
              if (!s.hasData) return const Center(child: CircularProgressIndicator());
              final l = s.data!
                  .where(_filtros[_f].$2)
                  .where((o) => '${o.matricula} ${o.cliente} ${o.mecanico}'.toLowerCase().contains(_q))
                  .toList();
              if (l.isEmpty) return vacio('No hay órdenes para mostrar');
              return ListView.separated(
                padding: const EdgeInsets.only(bottom: 88),
                itemCount: l.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) => OrdenTile(l[i]),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class OrdenDetalle extends StatelessWidget {
  final int id;
  const OrdenDetalle(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return StreamBuilder<List<OrdenResumen>>(
      stream: db.watchResumenes(ordenId: id),
      builder: (c, s) {
        if (!s.hasData || s.data!.isEmpty) return const Scaffold(body: Center(child: CircularProgressIndicator()));
        final o = s.data!.first;
        return Scaffold(
          appBar: AppBar(title: Text('Orden #${o.id}'), actions: [
            if (o.estado.abierta)
              PopupMenuButton<Estado>(
                icon: const Icon(Icons.sync_alt),
                tooltip: 'Cambiar estado',
                onSelected: (e) async {
                  if (e == Estado.cancelada &&
                      !await confirmar(c, '¿Cancelar la orden? Los repuestos volverán al inventario.')) {
                    return;
                  }
                  if (c.mounted) await run(c, () => db.cambiarEstado(o.id, e));
                },
                itemBuilder: (_) => [
                  for (final e in Estado.values)
                    if (e != o.estado) PopupMenuItem(value: e, child: Text(e.label)),
                ],
              ),
          ]),
          body: ListView(padding: const EdgeInsets.all(16), children: [
            Align(alignment: Alignment.centerLeft, child: EstadoChip(o.estado)),
            Card(
              child: ListTile(
                title: Text('${o.vehiculo} · ${o.matricula}'),
                subtitle: Text('Cliente: ${o.cliente}\nMecánico: ${o.mecanico}\nEntrada: ${fecha(o.fecha)}\nProblema: ${o.problema}'),
                isThreeLine: true,
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  _Cifra('Total', o.total),
                  _Cifra('Pagado', o.pagado),
                  _Cifra('Saldo', o.saldo, destacar: o.saldo > 0.005 && o.estado != Estado.cancelada),
                ]),
              ),
            ),
            _Trabajos(db, o),
            _Repuestos(db, o),
            _Pagos(db, o),
            const SizedBox(height: 32),
          ]),
        );
      },
    );
  }
}

class _Cifra extends StatelessWidget {
  final String label;
  final double v;
  final bool destacar;
  const _Cifra(this.label, this.v, {this.destacar = false});

  @override
  Widget build(BuildContext context) => Column(children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(money(v),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold, color: destacar ? Theme.of(context).colorScheme.error : null)),
      ]);
}

class _Trabajos extends StatelessWidget {
  final AppDatabase db;
  final OrdenResumen o;
  const _Trabajos(this.db, this.o);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Trabajo>>(
        stream: db.watchTrabajos(o.id),
        builder: (c, s) {
          final l = s.data ?? [];
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            seccion(
              c,
              'Trabajos (mano de obra)',
              o.estado.abierta
                  ? () async {
                      final r = await formDialog(c, 'Nuevo trabajo', [
                        const Field('Descripción'),
                        const Field('Precio de mano de obra', kind: Kind.decimal),
                      ]);
                      if (r == null || !c.mounted) return;
                      await run(c, () => db.agregarTrabajo(o.id, r[0], dec(r[1])));
                    }
                  : null,
            ),
            if (l.isEmpty) const Padding(padding: EdgeInsets.all(8), child: Text('Sin trabajos registrados')),
            for (final t in l)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(t.descripcion),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(money(t.precio)),
                  if (o.estado.abierta)
                    IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => run(c, () => db.quitarTrabajo(t.id))),
                ]),
              ),
          ]);
        },
      );
}

class _Repuestos extends StatelessWidget {
  final AppDatabase db;
  final OrdenResumen o;
  const _Repuestos(this.db, this.o);

  Future<void> _agregar(BuildContext c) async {
    final disp = (await db.listaRepuestos()).where((r) => r.existencias > 0).toList();
    if (!c.mounted) return;
    final r = await pick<Repuesto>(c, 'Repuesto', disp, (r) => '${r.nombre} · ${r.existencias} uds · ${money(r.precio)}');
    if (r == null || !c.mounted) return;
    final f = await formDialog(c, r.nombre, [Field('Cantidad', kind: Kind.int, initial: '1')]);
    if (f == null || !c.mounted) return;
    final w = await run(c, () => db.usarRepuesto(o.id, r.id, int.parse(f[0])));
    if (w != null && c.mounted) aviso(c, w);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<TypedResult>>(
        stream: db.watchRepuestosDeOrden(o.id),
        builder: (c, s) {
          final l = s.data ?? [];
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            seccion(c, 'Repuestos usados', o.estado.abierta ? () => _agregar(c) : null),
            if (l.isEmpty) const Padding(padding: EdgeInsets.all(8), child: Text('Sin repuestos')),
            for (final row in l)
              Builder(builder: (_) {
                final u = row.readTable(db.ordenRepuestos);
                final r = row.readTable(db.repuestos);
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text('${r.nombre} × ${u.cantidad}'),
                  subtitle: Text('${money(u.precioUnitario)} c/u'),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(money(u.cantidad * u.precioUnitario)),
                    if (o.estado.abierta)
                      IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => run(c, () => db.quitarRepuesto(u))),
                  ]),
                );
              }),
          ]);
        },
      );
}

class _Pagos extends StatelessWidget {
  final AppDatabase db;
  final OrdenResumen o;
  const _Pagos(this.db, this.o);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Pago>>(
        stream: db.watchPagos(o.id),
        builder: (c, s) {
          final l = s.data ?? [];
          final puede = o.estado != Estado.cancelada && o.saldo > 0.005;
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            seccion(
              c,
              'Pagos',
              puede
                  ? () async {
                      final r = await formDialog(c, 'Registrar pago (saldo ${money(o.saldo)})',
                          [Field('Monto', kind: Kind.decimal, initial: o.saldo.toStringAsFixed(2))]);
                      if (r == null || !c.mounted) return;
                      await run(c, () => db.registrarPago(o.id, dec(r[0])));
                    }
                  : null,
            ),
            if (l.isEmpty) const Padding(padding: EdgeInsets.all(8), child: Text('Sin pagos')),
            for (final p in l)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.payments_outlined),
                title: Text(money(p.monto)),
                subtitle: Text(fecha(p.fecha)),
              ),
          ]);
        },
      );
}
