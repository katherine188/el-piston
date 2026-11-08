import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/database.dart';
import '../ui.dart';
import 'ordenes.dart';

Future<void> formCliente(BuildContext c, AppDatabase db, [Cliente? cl]) async {
  final r = await formDialog(c, cl == null ? 'Nuevo cliente' : 'Editar cliente', [
    Field('Nombre', initial: cl?.nombre ?? ''),
    Field('Teléfono', kind: Kind.int, initial: cl?.telefono ?? ''),
    Field('Dirección', required: false, initial: cl?.direccion ?? ''),
  ]);
  if (r == null) return;
  await db.guardarCliente(id: cl?.id, nombre: r[0], telefono: r[1], direccion: r[2].isEmpty ? null : r[2]);
}

Future<void> formVehiculo(BuildContext c, AppDatabase db, int clienteId, [Vehiculo? v]) async {
  final r = await formDialog(c, v == null ? 'Nuevo vehículo' : 'Editar vehículo', [
    Field('Matrícula', initial: v?.matricula ?? ''),
    Field('Marca', initial: v?.marca ?? ''),
    Field('Modelo', initial: v?.modelo ?? ''),
    Field('Año', kind: Kind.int, initial: v == null ? '' : '${v.anio}'),
    Field('Kilometraje', kind: Kind.int, initial: v == null ? '' : '${v.km}'),
  ]);
  if (r == null || !c.mounted) return;
  final anio = int.parse(r[3]);
  if (anio < 1950 || anio > DateTime.now().year + 1) {
    aviso(c, 'Año fuera de rango');
    return;
  }
  await run(c, () => db.guardarVehiculo(
        id: v?.id, clienteId: clienteId, matricula: r[0], marca: r[1], modelo: r[2], anio: anio, km: int.parse(r[4])));
}

class ClientesTab extends StatefulWidget {
  const ClientesTab({super.key});
  @override
  State<ClientesTab> createState() => _ClientesTabState();
}

class _ClientesTabState extends State<ClientesTab> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => formCliente(context, db),
        icon: const Icon(Icons.person_add),
        label: const Text('Nuevo cliente'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Nombre o teléfono', border: OutlineInputBorder()),
            onChanged: (v) => setState(() => _q = v.toLowerCase()),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<Cliente>>(
            stream: db.watchClientes(),
            builder: (c, s) {
              if (!s.hasData) return const Center(child: CircularProgressIndicator());
              final l = s.data!.where((x) => '${x.nombre} ${x.telefono}'.toLowerCase().contains(_q)).toList();
              if (l.isEmpty) return vacio('Aún no hay clientes.\nToca “Nuevo cliente” para registrar el primero.');
              return ListView.separated(
                padding: const EdgeInsets.only(bottom: 88),
                itemCount: l.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) => ListTile(
                  leading: CircleAvatar(child: Text(l[i].nombre[0].toUpperCase())),
                  title: Text(l[i].nombre),
                  subtitle: Text(l[i].telefono),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => ClienteDetalle(l[i].id))),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class ClienteDetalle extends StatelessWidget {
  final int id;
  const ClienteDetalle(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return StreamBuilder<Cliente>(
      stream: db.watchCliente(id),
      builder: (c, s) {
        if (!s.hasData) return const Scaffold(body: Center(child: CircularProgressIndicator()));
        final cl = s.data!;
        return Scaffold(
          appBar: AppBar(title: Text(cl.nombre), actions: [
            IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () => formCliente(c, db, cl)),
          ]),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => formVehiculo(c, db, cl.id),
            icon: const Icon(Icons.directions_car),
            label: const Text('Vehículo'),
          ),
          body: ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 88), children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.phone),
              title: Text(cl.telefono),
              subtitle: Text(cl.direccion ?? 'Sin dirección'),
            ),
            seccion(c, 'Vehículos'),
            StreamBuilder<List<Vehiculo>>(
              stream: db.watchVehiculosDe(cl.id),
              builder: (c, vs) {
                final l = vs.data ?? [];
                if (l.isEmpty) return const Padding(padding: EdgeInsets.all(8), child: Text('Sin vehículos registrados'));
                return Column(children: [
                  for (final v in l)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.directions_car_outlined),
                      title: Text('${v.marca} ${v.modelo} ${v.anio}'),
                      subtitle: Text('${v.matricula} · ${v.km} km'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => VehiculoDetalle(v.id))),
                    ),
                ]);
              },
            ),
            StreamBuilder<List<OrdenResumen>>(
              stream: db.watchResumenes(clienteId: cl.id),
              builder: (c, os) {
                final l = os.data ?? [];
                final deuda = l.where((o) => o.estado != Estado.cancelada).fold<double>(0, (a, o) => a + o.saldo);
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Card(
                    color: deuda > 0.005 ? Theme.of(c).colorScheme.errorContainer : null,
                    child: ListTile(
                      leading: const Icon(Icons.account_balance_wallet_outlined),
                      title: Text(deuda > 0.005 ? 'Saldo pendiente: ${money(deuda)}' : 'Sin deuda'),
                    ),
                  ),
                  seccion(c, 'Historial de servicios'),
                  if (l.isEmpty) const Padding(padding: EdgeInsets.all(8), child: Text('Sin servicios todavía')),
                  for (final o in l) OrdenTile(o),
                ]);
              },
            ),
          ]),
        );
      },
    );
  }
}

class VehiculoDetalle extends StatelessWidget {
  final int id;
  const VehiculoDetalle(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return StreamBuilder<Vehiculo>(
      stream: db.watchVehiculo(id),
      builder: (c, s) {
        if (!s.hasData) return const Scaffold(body: Center(child: CircularProgressIndicator()));
        final v = s.data!;
        return Scaffold(
          appBar: AppBar(title: Text(v.matricula), actions: [
            IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () => formVehiculo(c, db, v.clienteId, v)),
          ]),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => nuevaOrden(c, vehiculo: v),
            icon: const Icon(Icons.add),
            label: const Text('Nueva orden'),
          ),
          body: ListView(padding: const EdgeInsets.only(bottom: 88), children: [
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: Text('${v.marca} ${v.modelo} · ${v.anio}'),
              subtitle: Text('Último kilometraje: ${v.km} km'),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: seccion(c, 'Historial de servicios')),
            StreamBuilder<List<OrdenResumen>>(
              stream: db.watchResumenes(vehiculoId: v.id),
              builder: (c, os) {
                final l = os.data ?? [];
                if (l.isEmpty) return const Padding(padding: EdgeInsets.all(24), child: Text('Este vehículo aún no tiene servicios'));
                return Column(children: [for (final o in l) OrdenTile(o)]);
              },
            ),
          ]),
        );
      },
    );
  }
}
