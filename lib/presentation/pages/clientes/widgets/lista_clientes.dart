import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/presentation/pages/clientes/widgets/detalles_cliente.dart';
import 'package:pos/presentation/viewmodels/general_data/general_data.dart';
import 'package:pos/domain/entities/cliente.dart';

class ListaClientes extends ConsumerWidget {
  const ListaClientes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientes = ref.read(clientesFiltradosProv);

    void mostrarDetalles(BuildContext context, ClienteOB cliente) {
      showDialog(
        context: context,
        builder: (context) => DetallesCliente(cliente: cliente),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (BuildContext context, int index) {
          final cliente = clientes[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => mostrarDetalles(context, cliente),
              borderRadius: BorderRadius.circular(10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    spacing: 8,
                    children: [
                      Text(
                        'ID cliente: ${cliente.id_Cliente}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Razón Social: ${cliente.razon_Social}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'RFC: ${cliente.RFC}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
