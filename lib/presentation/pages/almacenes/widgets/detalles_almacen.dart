import 'package:flutter/material.dart';
import 'package:pos/domain/entities/almacen.dart';

class DetallesAlmacen extends StatelessWidget {
  final AlmacenOB almacen;
  const DetallesAlmacen({super.key, required this.almacen});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "ID almacén: ${almacen.id_almacen}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nombre: ${almacen.nombre}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Nombre orden: ${almacen.nombreOrden}",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
