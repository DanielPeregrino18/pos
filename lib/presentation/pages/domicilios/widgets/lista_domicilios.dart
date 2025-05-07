import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/domain/entities/domicilio.dart';
import 'package:pos/presentation/pages/domicilios/widgets/detalles_domicilio.dart';
import 'package:pos/presentation/viewmodels/general_data/view_models/domicilios_viewmodel.dart';

class ListaDomicilios extends ConsumerWidget {
  const ListaDomicilios({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final domicilios = ref.read(domiciliosFiltradosProv);

    void mostrarDetalles(BuildContext context, DomicilioOB domicilio) {
      showDialog(
        context: context,
        builder: (context) => DetallesDomicilio(domicilio: domicilio),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: domicilios.length,
        itemBuilder: (BuildContext context, int index) {
          final domicilio = domicilios[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => mostrarDetalles(context, domicilio),
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
                        'ID cliente: ${domicilio.id_Cliente}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "Domicilio: ${domicilio.domicilio}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Colonia: ${domicilio.colonia}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Ciudad: ${domicilio.ciudad}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "CP: ${domicilio.c_p}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Plazo: ${domicilio.plazo}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Estado: ${domicilio.estado}",
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
