import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/domain/entities/vendedor.dart';
import 'package:pos/presentation/pages/vendedores/widgets/detalles_vendedor.dart';
import 'package:pos/presentation/pages/vendedores/widgets/lista_vendedores.dart';
import 'package:pos/presentation/widgets/general_app_bar.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';
import 'package:pos/presentation/viewmodels/general_data/view_models/vendedores_viewmodel.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';

class Vendedores extends ConsumerStatefulWidget {
  const Vendedores({super.key});

  @override
  ConsumerState<Vendedores> createState() => _VendedoresState();
}

class _VendedoresState extends ConsumerState<Vendedores> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void mostrarDetalles(BuildContext context, VendedorOB vendedor) {
    showDialog(
      context: context,
      builder: (context) => DetallesVendedor(vendedor: vendedor),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: GeneralAppBar(theme: theme, title: "Vendedores"),
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
                barHintText: "Buscar vendedor por nombre",
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
                  final vendedores = ref.read(vendedoresFiltradosProv);
                  return vendedores.map(
                    (vendedor) => ListTile(
                      title: Text(
                        'ID usuario: ${vendedor.id_Usuario}',
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
                            "Nombre: ${vendedor.nombre}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      onTap: () {
                        // controller.clear();
                        mostrarDetalles(context, vendedor);
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(child: ListaVendedores()),
          ],
        ),
      ),
    );
  }
}
