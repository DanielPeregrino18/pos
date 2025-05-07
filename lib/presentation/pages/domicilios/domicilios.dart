import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/domain/entities/domicilio.dart';
import 'package:pos/presentation/pages/domicilios/widgets/detalles_domicilio.dart';
import 'package:pos/presentation/pages/domicilios/widgets/lista_domicilios.dart';
import 'package:pos/presentation/widgets/general_app_bar.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';
import 'package:pos/presentation/viewmodels/general_data/general_data.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';

class Domicilios extends ConsumerStatefulWidget {
  const Domicilios({super.key});

  @override
  ConsumerState<Domicilios> createState() => _DomiciliosState();
}

class _DomiciliosState extends ConsumerState<Domicilios> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void mostrarDetalles(BuildContext context, DomicilioOB domicilio) {
    showDialog(
      context: context,
      builder: (context) => DetallesDomicilio(domicilio: domicilio),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: GeneralAppBar(theme: theme, title: "Domicilios"),
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
                barHintText: "Buscar domicilio",
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
                  final domicilios = ref.read(domiciliosFiltradosProv);
                  return domicilios.map(
                    (domicilio) => ListTile(
                      title: Text(
                        'ID cliente: ${domicilio.id_Cliente}',
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
                            "Domicilio: ${domicilio.domicilio}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Ciudad: ${domicilio.ciudad}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      onTap: () {
                        // controller.clear();
                        mostrarDetalles(context, domicilio);
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(child: ListaDomicilios()),
          ],
        ),
      ),
    );
  }
}
