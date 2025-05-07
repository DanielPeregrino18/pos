import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/domain/entities/cifras.dart';
import 'package:pos/presentation/pages/cifras/widgets/detalles_cifras.dart';
import 'package:pos/presentation/viewmodels/general_data/view_models/cifras_viewmodel.dart';

class ListaCifras extends ConsumerWidget {
  const ListaCifras({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cifras = ref.read(cifrasFiltradasProv);

    void mostrarDetalles(BuildContext context, CifrasOB cifras) {
      showDialog(
        context: context,
        builder: (context) => DetallesCifras(cifras: cifras),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: cifras.length,
        itemBuilder: (BuildContext context, int index) {
         final cifrasItem = cifras[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => mostrarDetalles(context, cifrasItem),
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
                        'Paridad: ${cifrasItem.paridad}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "ID Mov.C: ${cifrasItem.idMovC}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "ID Mov.P: ${cifrasItem.idMovP}",
                        style: const TextStyle(fontSize: 16),
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
