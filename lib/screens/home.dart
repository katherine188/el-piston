import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/database.dart';
import '../ui.dart';
import 'clientes.dart';
import 'inventario.dart';
import 'ordenes.dart';
import 'reportes.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _i = 0;
  static const _pages = [Inicio(), OrdenesTab(), ClientesTab(), InventarioTab(), ReportesTab()];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: _i, children: _pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _i,
          onDestinationSelected: (v) => setState(() => _i = v),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Inicio'),
            NavigationDestination(icon: Icon(Icons.build_outlined), selectedIcon: Icon(Icons.build), label: 'Órdenes'),
            NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'Clientes'),
            NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2), label: 'Inventario'),
            NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'Reportes'),
          ],
        ),
      );
}

/// Panel: órdenes abiertas por estado, carga por mecánico y alertas de stock.
class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('El Pistón')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        StreamBuilder<List<OrdenResumen>>(
          stream: db.watchResumenes(),
          builder: (c, s) {
            final ab = (s.data ?? []).where((o) => o.estado.abierta).toList();
            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Órdenes abiertas: ${ab.length}', style: t.titleLarge),
              const SizedBox(height: 8),
              Wrap(spacing: 8, runSpacing: 4, children: [
                for (final e in Estado.values.where((e) => e.abierta))
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: estadoColor(e),
                      child: Text('${ab.where((o) => o.estado == e).length}',
                          style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    label: Text(e.label),
                  ),
              ]),
              const SizedBox(height: 24),
              Text('Carga por mecánico', style: t.titleLarge),
              StreamBuilder<List<Mecanico>>(
                stream: db.watchMecanicos(),
                builder: (c, ms) => Column(children: [
                  for (final m in ms.data ?? <Mecanico>[])
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.engineering),
                      title: Text(m.nombre),
                      subtitle: Text('${ab.where((o) => o.mecanicoId == m.id).length} órdenes abiertas'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: 'Renombrar',
                        onPressed: () async {
                          final r = await formDialog(c, 'Nombre del mecánico', [Field('Nombre', initial: m.nombre)]);
                          if (r != null) await db.renombrarMecanico(m.id, r[0]);
                        },
                      ),
                    ),
                ]),
              ),
            ]);
          },
        ),
        const SizedBox(height: 24),
        Text('Repuestos por agotarse', style: t.titleLarge),
        StreamBuilder<List<Repuesto>>(
          stream: db.watchStockBajo(),
          builder: (c, s) {
            final l = s.data ?? [];
            if (l.isEmpty) return const ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.check_circle_outline), title: Text('Inventario en orden'));
            return Column(children: [
              for (final r in l)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.warning_amber, color: Theme.of(c).colorScheme.error),
                  title: Text(r.nombre),
                  subtitle: Text('${r.codigo} · mínimo ${r.stockMinimo}'),
                  trailing: Text('${r.existencias}', style: t.titleMedium?.copyWith(color: Theme.of(c).colorScheme.error)),
                ),
            ]);
          },
        ),
      ]),
    );
  }
}
