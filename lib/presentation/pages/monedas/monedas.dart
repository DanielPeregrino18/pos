import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/domain/entities/moneda.dart';
import 'package:pos/presentation/pages/monedas/widgets/detallles_moneda.dart';
import 'package:pos/presentation/pages/monedas/widgets/lista_monedas.dart';
import 'package:pos/presentation/widgets/general_app_bar.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';
import 'package:pos/presentation/viewmodels/general_data/general_data.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';

class Monedas extends ConsumerStatefulWidget {
  const Monedas({super.key});

  @override
  ConsumerState<Monedas> createState() => _MonedasState();
}

class _MonedasState extends ConsumerState<Monedas> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void mostrarDetalles(BuildContext context, MonedaOB moneda) {
    showDialog(
      context: context,
      builder: (context) => DetallesMonedas(moneda: moneda),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: GeneralAppBar(theme: theme, title: "Monedas"),
      drawer: DrawerPos(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: SearchAnchor.bar(
                dividerColor: theme.primary,
                viewBackgroundColor: theme.onPrimary,
                barHintText: "Buscar moneda por nombre",
                viewConstraints: BoxConstraints(
                  minWidth: 550.0,
                  minHeight: 0,
                  maxHeight: 58,
                ),
                suggestionsBuilder: (context, controller) {
                  if (controller.text.isEmpty) {
                    return <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Center(child: Text("Sin historial")),
                      ),
                    ];
                  }
                  ref.read(inputSearchProvider.notifier).state =
                      controller.value.text;
                  final monedas = ref.read(monedasFiltradasProv);
                  return monedas.map(
                    (moneda) => ListTile(
                      title: Text(
                        'ID moneda: ${moneda.IdMoneda}',
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nombre: ${moneda.Nombre}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Clave SAT: ${moneda.Clave_SAT}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      onTap: () {
                        // controller.clear();
                        mostrarDetalles(context, moneda);
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(child: ListaMonedas()),
          ],
        ),
      ),
    );
  }
}
