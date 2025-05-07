import 'package:flutter/material.dart';
import 'package:pos/domain/entities/cliente.dart';

class DetallesCliente extends StatelessWidget {
  final ClienteOB cliente;
  const DetallesCliente({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "ID Cliente: ${cliente.id_Cliente}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Razón Social: ${cliente.razon_Social}",
            style: const TextStyle(fontSize: 16),
          ),
          Text("RFC: ${cliente.RFC}", style: const TextStyle(fontSize: 16)),
          Text(
            "Descuento: ${cliente.descuento}",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "Número de Plazo: ${cliente.NO_Plazo}",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "Id de lista: ${cliente.id_lista}",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "CFI: ${cliente.cfdi}",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
