import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/domain/entities/almacen.dart';
import 'package:pos/presentation/pages/almacenes/widgets/detalles_almacen.dart';
import 'package:pos/presentation/viewmodels/general_data/general_data.dart';

class ListaAlmacenes extends ConsumerWidget {
  const ListaAlmacenes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final almacenes = ref.read(almacenesFiltradosProv);

    void mostrarDetalles(BuildContext context, AlmacenOB almacen) {
      showDialog(
        context: context,
        builder: (_) => DetallesAlmacen(almacen: almacen),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: almacenes.length,
        itemBuilder: (BuildContext context, int index) {
          final almacen = almacenes[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => mostrarDetalles(context, almacen),
              borderRadius: BorderRadius.circular(10),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID almacén: ${almacen.id_almacen}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Nombre: ${almacen.nombre}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Nombre almacén: ${almacen.nombreOrden}',
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
