import 'package:flutter/material.dart';
import 'package:pos/domain/entities/moneda.dart';

class DetallesMonedas extends StatelessWidget {
  final MonedaOB moneda;
  const DetallesMonedas({super.key, required this.moneda});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "ID Moneda: ${moneda.IdMoneda}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nombre: ${moneda.Nombre}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Clave SAT: ${moneda.Clave_SAT}",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
