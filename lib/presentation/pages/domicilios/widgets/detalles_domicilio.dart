import 'package:flutter/material.dart';
import 'package:pos/domain/entities/domicilio.dart';

class DetallesDomicilio extends StatelessWidget {
  final DomicilioOB domicilio;
  const DetallesDomicilio({super.key, required this.domicilio});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "ID Cliente: ${domicilio.id_Cliente}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Domicilio: ${domicilio.domicilio}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Colonia: ${domicilio.colonia}",
            style: const TextStyle(fontSize: 16),
          ),
          Text("Ciudad: ${domicilio.ciudad}", style: TextStyle(fontSize: 16)),
          Text("CP: ${domicilio.c_p}", style: TextStyle(fontSize: 16)),
          Text("Plazo: ${domicilio.plazo}", style: TextStyle(fontSize: 16)),
          Text("Estado: ${domicilio.estado}", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
