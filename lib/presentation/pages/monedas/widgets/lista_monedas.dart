import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/domain/entities/moneda.dart';
import 'package:pos/presentation/pages/monedas/widgets/detallles_moneda.dart';
import 'package:pos/presentation/viewmodels/general_data/general_data.dart';

class ListaMonedas extends ConsumerWidget {
  const ListaMonedas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monedas = ref.read(monedasFiltradasProv);

    void mostrarDetalles(BuildContext context, MonedaOB moneda) {
      showDialog(
        context: context,
        builder: (context) => DetallesMonedas(moneda: moneda),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: monedas.length,
        itemBuilder: (BuildContext context, int index) {
          final moneda = monedas[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => mostrarDetalles(context, moneda),
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
                        'ID moneda: ${moneda.IdMoneda}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Nombre: ${moneda.Nombre}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Clave SAT: ${moneda.Clave_SAT}',
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
