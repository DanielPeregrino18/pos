import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/domain/entities/cifras.dart';
import 'package:pos/presentation/pages/cifras/widgets/detalles_cifras.dart';
import 'package:pos/presentation/pages/cifras/widgets/lista_cifras.dart';
import 'package:pos/presentation/widgets/general_app_bar.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';
import 'package:pos/presentation/viewmodels/general_data/view_models/cifras_viewmodel.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';

class Cifras extends ConsumerStatefulWidget {
  const Cifras({super.key});

  @override
  ConsumerState<Cifras> createState() => _CifrasState();
}

class _CifrasState extends ConsumerState<Cifras> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void mostrarDetalles(BuildContext context, CifrasOB cifras) {
    showDialog(
      context: context,
      builder: (context) => DetallesCifras(cifras: cifras),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: GeneralAppBar(theme: theme, title: "Cifras"),
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
                barHintText: "Buscar cifras por ID Mov.C",
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
                  final cifras = ref.read(cifrasFiltradasProv);
                  return cifras.map(
                    (cifrasItem) => ListTile(
                      title: Text(
                        'Paridad: ${cifrasItem.paridad}',
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
                            "Id Mov.C: ${cifrasItem.idMovC}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Id Mov.P: ${cifrasItem.idMovP}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      onTap: () {
                        // controller.clear();
                        mostrarDetalles(context, cifrasItem);
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(child: ListaCifras()),
          ],
        ),
      ),
    );
  }
}
