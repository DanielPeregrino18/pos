import 'package:flutter/material.dart';
import 'package:pos/domain/entities/cifras.dart';

class DetallesCifras extends StatelessWidget {
  final CifrasOB cifras;
  const DetallesCifras({super.key, required this.cifras});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Paridad: ${cifras.paridad}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ID Mov.C: ${cifras.idMovC}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "ID Mov.C: ${cifras.idMovP}",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
