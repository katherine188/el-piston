import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/database.dart';
import '../ui.dart';

Future<void> formRepuesto(BuildContext c, AppDatabase db, [Repuesto? r]) async {
  final f = await formDialog(c, r == null ? 'Nuevo repuesto' : 'Editar repuesto', [
    Field('Nombre', initial: r?.nombre ?? ''),
    Field('Código', initial: r?.codigo ?? ''),
    Field('Precio de venta', kind: Kind.decimal, initial: r == null ? '' : r.precio.toStringAsFixed(2)),
    Field('Existencias', kind: Kind.int, initial: r == null ? '' : '${r.existencias}'),
    Field('Stock mínimo (alerta)', kind: Kind.int, initial: '${r?.stockMinimo ?? 3}'),
  ]);
  if (f == null || !c.mounted) return;
  await run(c, () => db.guardarRepuesto(
        id: r?.id,
        nombre: f[0],
        codigo: f[1],
        precio: dec(f[2]),
        existencias: int.parse(f[3]),
        stockMinimo: int.parse(f[4]),
      ));
}

class InventarioTab extends StatefulWidget {
  const InventarioTab({super.key});
  @override
  State<InventarioTab> createState() => _InventarioTabState();
}

class _InventarioTabState extends State<InventarioTab> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    final err = Theme.of(context).colorScheme.error;
    return Scaffold(
      appBar: AppBar(title: const Text('Inventario de repuestos')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => formRepuesto(context, db),
        icon: const Icon(Icons.add),
        label: const Text('Repuesto'),
      ),
      body: StreamBuilder<List<Repuesto>>(
        stream: db.watchRepuestos(),
        builder: (c, s) {
          if (!s.hasData) return const Center(child: CircularProgressIndicator());
          final todos = s.data!;
          final bajos = todos.where((r) => r.existencias <= r.stockMinimo).length;
          final l = todos.where((r) => '${r.nombre} ${r.codigo}'.toLowerCase().contains(_q)).toList();
          return Column(children: [
            if (bajos > 0)
              Container(
                width: double.infinity,
                color: Theme.of(c).colorScheme.errorContainer,
                padding: const EdgeInsets.all(12),
                child: Row(children: [
                  Icon(Icons.warning_amber, color: err),
                  const SizedBox(width: 8),
                  Text('$bajos repuesto(s) por agotarse'),
                ]),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Nombre o código', border: OutlineInputBorder()),
                onChanged: (v) => setState(() => _q = v.toLowerCase()),
              ),
            ),
            Expanded(
              child: l.isEmpty
                  ? vacio('No hay repuestos.\nToca “Repuesto” para agregar el primero.')
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 88),
                      itemCount: l.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final r = l[i];
                        final bajo = r.existencias <= r.stockMinimo;
                        return ListTile(
                          onTap: () => formRepuesto(c, db, r),
                          leading: Icon(bajo ? Icons.warning_amber : Icons.settings_outlined, color: bajo ? err : null),
                          title: Text(r.nombre),
                          subtitle: Text('${r.codigo} · ${money(r.precio)}${bajo ? ' · ¡Por agotarse!' : ''}'),
                          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text('${r.existencias}',
                                style: Theme.of(c).textTheme.titleMedium?.copyWith(color: bajo ? err : null, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              tooltip: 'Reponer',
                              onPressed: () async {
                                final f = await formDialog(c, 'Reponer ${r.nombre}', [const Field('Cantidad recibida', kind: Kind.int)]);
                                if (f == null || !c.mounted) return;
                                await run(c, () => db.reponer(r.id, int.parse(f[0])));
                              },
                            ),
                          ]),
                        );
                      },
                    ),
            ),
          ]);
        },
      ),
    );
  }
}
