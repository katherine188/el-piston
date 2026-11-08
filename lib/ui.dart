import 'package:flutter/material.dart';

import 'db/database.dart';

String money(num v) => '\$${v.toStringAsFixed(2)}';
String fecha(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
double dec(String s) => double.parse(s.replaceAll(',', '.'));

Color estadoColor(Estado e) => switch (e) {
      Estado.recibida => Colors.blueGrey,
      Estado.enDiagnostico => Colors.amber.shade800,
      Estado.enReparacion => Colors.orange.shade800,
      Estado.listaParaEntregar => Colors.green,
      Estado.entregada => Colors.teal.shade700,
      Estado.cancelada => Colors.red.shade700,
    };

class EstadoChip extends StatelessWidget {
  final Estado e;
  const EstadoChip(this.e, {super.key});

  @override
  Widget build(BuildContext context) => Chip(
        label: Text(e.label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        backgroundColor: estadoColor(e),
        side: BorderSide.none,
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.zero,
      );
}

Widget vacio(String t) => Center(
      child: Padding(padding: const EdgeInsets.all(32), child: Text(t, textAlign: TextAlign.center)),
    );

Widget seccion(BuildContext c, String t, [VoidCallback? onAdd]) => Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(children: [
        Text(t, style: Theme.of(c).textTheme.titleMedium),
        const Spacer(),
        if (onAdd != null) IconButton.filledTonal(icon: const Icon(Icons.add), tooltip: 'Agregar', onPressed: onAdd),
      ]),
    );

void aviso(BuildContext c, String m) => ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(m)));

/// Ejecuta una operación de BD y muestra los errores de negocio como aviso.
Future<T?> run<T>(BuildContext c, Future<T> Function() f) async {
  try {
    return await f();
  } on AppError catch (e) {
    if (c.mounted) aviso(c, e.msg);
    return null;
  }
}

Future<bool> confirmar(BuildContext c, String msg) async =>
    await showDialog<bool>(
      context: c,
      builder: (ctx) => AlertDialog(
        content: Text(msg),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('No')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Sí')),
        ],
      ),
    ) ??
    false;

Future<T?> pick<T>(BuildContext c, String title, List<T> items, String Function(T) label) => showDialog<T>(
      context: c,
      builder: (ctx) => SimpleDialog(title: Text(title), children: [
        if (items.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Text('No hay elementos disponibles')),
        for (final i in items) SimpleDialogOption(onPressed: () => Navigator.pop(ctx, i), child: Text(label(i))),
      ]),
    );

enum Kind { text, int, decimal }

class Field {
  final String label;
  final Kind kind;
  final bool required;
  final String initial;
  const Field(this.label, {this.kind = Kind.text, this.required = true, this.initial = ''});
}

/// Formulario genérico con validación. Devuelve los valores como texto, o null si se cancela.
Future<List<String>?> formDialog(BuildContext context, String title, List<Field> fields) {
  final key = GlobalKey<FormState>();
  final ctrls = [for (final f in fields) TextEditingController(text: f.initial)];
  return showDialog<List<String>>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            for (var i = 0; i < fields.length; i++)
              TextFormField(
                controller: ctrls[i],
                autofocus: i == 0,
                decoration: InputDecoration(labelText: fields[i].label + (fields[i].required ? '' : ' (opcional)')),
                textCapitalization: fields[i].kind == Kind.text ? TextCapitalization.sentences : TextCapitalization.none,
                keyboardType: fields[i].kind == Kind.text
                    ? TextInputType.text
                    : TextInputType.numberWithOptions(decimal: fields[i].kind == Kind.decimal),
                validator: (v) {
                  final t = (v ?? '').trim();
                  if (t.isEmpty) return fields[i].required ? 'Obligatorio' : null;
                  if (fields[i].kind == Kind.int && int.tryParse(t) == null) return 'Número entero';
                  if (fields[i].kind == Kind.decimal && (double.tryParse(t.replaceAll(',', '.')) ?? -1) < 0) {
                    return 'Número válido';
                  }
                  return null;
                },
              ),
          ]),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
        FilledButton(
          onPressed: () {
            if (key.currentState!.validate()) Navigator.pop(ctx, [for (final c in ctrls) c.text.trim()]);
          },
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
}
