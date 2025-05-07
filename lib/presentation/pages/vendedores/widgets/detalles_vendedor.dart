import 'package:flutter/material.dart';
import 'package:pos/domain/entities/vendedor.dart';

class DetallesVendedor extends StatelessWidget {
  final VendedorOB vendedor;
  const DetallesVendedor({super.key, required this.vendedor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "ID Usuario: ${vendedor.id_Usuario}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nombre: ${vendedor.nombre}",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
