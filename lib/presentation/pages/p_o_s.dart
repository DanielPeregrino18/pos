import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pos/presentation/viewmodels/PosViewModel.dart';
import 'package:pos/presentation/viewmodels/background_dismissible.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';

class POS extends ConsumerStatefulWidget {
  const POS({Key? key}) : super(key: key);

  @override
  ConsumerState<POS> createState() => _POSState();
}

class _POSState extends ConsumerState<POS> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppbarPos(theme),
      drawer: DrawerPos(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SearchAnchor.bar(
                dividerColor: theme.primary,
                viewBackgroundColor: theme.onPrimary,
                barHintText: "Buscar Productos",
                viewConstraints: BoxConstraints(
                  minWidth: 550.0,
                  minHeight: 0,
                  maxHeight: 58,
                ),
                suggestionsBuilder: (context, controller) {
                  if (controller.text.isEmpty) {
                    return <Widget>[Center(child: Text("No hay historial."))];
                  }
                  ref.read(inputSearchProvider.notifier).state =
                      controller.value.text;
                  final productosFiltradosProvider = ref.read(
                    productosFIltradosProvider,
                  );
                  return productosFiltradosProvider.map(
                    (prodFiltrado) => ListTile(
                      title: Text(
                        prodFiltrado.nombre!,
                        style: TextStyle(
                          fontSize: 25,
                          color: theme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        "Precio: \$${prodFiltrado.precio!.toStringAsFixed(2)}, Existencia: ${prodFiltrado.stock}",
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        setState(() {
                          ref.read(carritoProvider).agregar(prodFiltrado);
                        });
                        controller.clear();
                        context.pop();
                      },
                    ),
                  );
                },
              ),
            ),
            Consumer(
              builder: (context, ref, _) {
                final carritoRef = ref.read(carritoProvider);
                return Expanded(
                  child: ListView.builder(
                    itemCount: carritoRef.carrito.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        background: BackgroundDismissible(),
                        onDismissed: (direction) {
                          carritoRef.delete(index);
                        },
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                int currentValue =
                                    carritoRef.carrito[index]["cantidad"];
                                return AlertDialog(
                                  title: Text(
                                    "${carritoRef.carrito[index]['producto'].nombre}",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: Container(
                                    height: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Canitdad: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        StatefulBuilder(
                                          builder: (context, SBsetState) {
                                            return NumberPicker(
                                              value: currentValue,
                                              minValue: 1,
                                              maxValue:
                                                  carritoRef
                                                      .carrito[index]["producto"]
                                                      .stock,
                                              onChanged: (value) {
                                                SBsetState(
                                                  () => currentValue = value,
                                                );
                                              },
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: Colors.black26,
                                                  width: 5,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: Text("Cancelar"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        carritoRef.setCantidad(index, currentValue);
                                      },
                                      child: Text("Aceptar"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 40,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${carritoRef.carrito[index]['producto'].nombre}",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "cantidad: ${carritoRef.carrito[index]['cantidad']}",
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "\$${carritoRef.carrito[index]['total'].toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton.large(
                heroTag: "btn1",
                onPressed: () {
                  setState(() {
                    ref.read(carritoProvider).clear();
                  });
                },
                child: Icon(Icons.cleaning_services),
              ),
              Text(
                "Total: \$${ref.watch(carritoProvider).totalCarrito.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              ),
              FloatingActionButton.large(
                heroTag: "btn2",
                onPressed: () {},
                child: Icon(Icons.attach_money),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar AppbarPos(ColorScheme theme) {
    return AppBar(
      title: Text(
        "Punto de venta",
        style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: theme.onPrimary),
      backgroundColor: theme.primary,
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 40)),
      ],
    );
  }
}
