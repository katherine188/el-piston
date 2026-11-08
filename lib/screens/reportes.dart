import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/database.dart';
import '../ui.dart';
import 'clientes.dart';

class ReportesTab extends StatefulWidget {
  const ReportesTab({super.key});
  @override
  State<ReportesTab> createState() => _ReportesTabState();
}

class _ReportesTabState extends State<ReportesTab> {
  late DateTimeRange _rango = () {
    final n = DateTime.now();
    return DateTimeRange(start: DateTime(n.year, n.month), end: DateTime(n.year, n.month + 1, 0));
  }();

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Reportes')),
      body: StreamBuilder<List<OrdenResumen>>(
        stream: db.watchResumenes(),
        builder: (c, s) {
          final validas = (s.data ?? []).where((o) => o.estado != Estado.cancelada).toList();
          final fin = _rango.end.add(const Duration(days: 1));
          final enRango = validas.where((o) => !o.fecha.isBefore(_rango.start) && o.fecha.isBefore(fin)).toList();
          final facturado = enRango.fold<double>(0, (a, o) => a + o.total);
          final cobrado = enRango.fold<double>(0, (a, o) => a + o.pagado);

          final deuda = <int, double>{};
          final nombres = <int, String>{};
          for (final o in validas.where((o) => o.saldo > 0.005)) {
            deuda[o.clienteId] = (deuda[o.clienteId] ?? 0) + o.saldo;
            nombres[o.clienteId] = o.cliente;
          }
          final deudores = deuda.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

          return ListView(padding: const EdgeInsets.all(16), children: [
            Text('Facturación por período', style: t.titleLarge),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.date_range),
              label: Text('${fecha(_rango.start)} – ${fecha(_rango.end)}'),
              onPressed: () async {
                final r = await showDateRangePicker(
                    context: c, firstDate: DateTime(2020), lastDate: DateTime(2100), initialDateRange: _rango);
                if (r != null) setState(() => _rango = r);
              },
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Text(money(facturado), style: t.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Text('facturado en ${enRango.length} orden(es)'),
                  const Divider(height: 24),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Column(children: [Text('Cobrado', style: t.bodySmall), Text(money(cobrado), style: t.titleMedium)]),
                    Column(children: [Text('Por cobrar', style: t.bodySmall), Text(money(facturado - cobrado), style: t.titleMedium)]),
                  ]),
                ]),
              ),
            ),
            const SizedBox(height: 16),
            Text('Clientes con saldo pendiente', style: t.titleLarge),
            if (deudores.isEmpty) const ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.check_circle_outline), title: Text('Nadie debe nada')),
            for (final d in deudores)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.person_outline),
                title: Text(nombres[d.key]!),
                trailing: Text(money(d.value), style: t.titleMedium?.copyWith(color: Theme.of(c).colorScheme.error)),
                onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => ClienteDetalle(d.key))),
              ),
          ]);
        },
      ),
    );
  }
}
