import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/domain/entities/almacen.dart';
import 'package:pos/presentation/pages/almacenes/widgets/detalles_almacen.dart';
import 'package:pos/presentation/pages/almacenes/widgets/lista_almacenes.dart';
import 'package:pos/presentation/viewmodels/general_data/general_data.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';
import 'package:pos/presentation/widgets/general_app_bar.dart';

class Almacenes extends ConsumerStatefulWidget {
  const Almacenes({super.key});

  @override
  ConsumerState<Almacenes> createState() => _AlmacenesState();
}

class _AlmacenesState extends ConsumerState<Almacenes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void mostrarDetalles(BuildContext context, AlmacenOB almacen) {
    showDialog(
      context: context,
      builder: (_) => DetallesAlmacen(almacen: almacen),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: GeneralAppBar(theme: theme, title: "Almacenes"),
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
                barHintText: "Buscar almacén por nombre",
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
                  final almacenes = ref.read(almacenesFiltradosProv);
                  return almacenes.map(
                    (almacenOB) => ListTile(
                      leading: Icon(
                        Icons.store,
                        size: 60,
                        color: theme.primary,
                      ),
                      title: Text(
                        'ID: ${almacenOB.id_almacen}',
                        style: TextStyle(
                          fontSize: 25,
                          color: theme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nombre: ${almacenOB.nombre}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Nombre almacén: ${almacenOB.nombreOrden}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      onTap: () {
                        // controller.clear();
                        mostrarDetalles(context, almacenOB);
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(child: ListaAlmacenes()),
          ],
        ),
      ),
    );
  }
}
