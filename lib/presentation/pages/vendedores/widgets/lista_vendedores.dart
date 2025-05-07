import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/domain/entities/vendedor.dart';
import 'package:pos/presentation/pages/vendedores/widgets/detalles_vendedor.dart';
import 'package:pos/presentation/viewmodels/general_data/view_models/vendedores_viewmodel.dart';

class ListaVendedores extends ConsumerWidget {
  const ListaVendedores({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendedores = ref.read(vendedoresFiltradosProv);

    void mostrarDetalles(BuildContext context, VendedorOB vendedor) {
      showDialog(
        context: context,
        builder: (context) => DetallesVendedor(vendedor: vendedor),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: vendedores.length,
        itemBuilder: (BuildContext context, int index) {
          final vendedor = vendedores[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => mostrarDetalles(context, vendedor),
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
                        'ID Usuario: ${vendedor.id_Usuario}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Nombre: ${vendedor.nombre}',
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
