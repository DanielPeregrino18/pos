import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/servicios/ProductoServicio.dart';
import 'package:pos/data/modelos/producto.dart';
import 'package:pos/presentation/viewmodels/ProductosViewModel.dart';
import 'package:pos/presentation/widgets/background_dismissible.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';

class Productos extends ConsumerStatefulWidget {
  const Productos({Key? key}) : super(key: key);

  @override
  ConsumerState<Productos> createState() => _ProductosState();
}

class _ProductosState extends ConsumerState<Productos> {

  @override
  void initState() {
    super.initState();
    ref.read(productosVMProvider).getAllProductos();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme
        .of(context)
        .colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Productos",
          style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.onPrimary),
        backgroundColor: theme.primary,
        actions: <Widget>[
          IconButton(onPressed: () {
            Navigator.pop(context);
            context.go("/productos/addproducto");
          }, icon: Icon(Icons.add, size: 40)),
        ],
      ),
      drawer: DrawerPos(),
      body: Column(
        spacing: 10,
        children: [
          TextFormField(
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: theme.primary),
              ),
              prefixIcon: Icon(Icons.search),
              labelText: "Buscar por nombre",
              labelStyle: TextStyle(color: theme.primary),
            ),
            onChanged: (value) {
              ref.read(productosVMProvider).filtrarProductos(value);
            },
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.25,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        "ID Producto",
                        style: TextStyle(color: theme.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.25,
                    child: Text(
                      "Nombre",
                      style: TextStyle(color: theme.primary,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.25,
                    child: Text(
                      "Precio",
                      style: TextStyle(color: theme.primary,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.25,
                    child: Text(
                      "Existencias",
                      style: TextStyle(color: theme.primary,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ref
                  .watch(productosVMProvider)
                  .productosFiltrados
                  .length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: BackgroundDismissible(),
                  onDismissed: (direction) {
                    bool res = ref.read(productosVMProvider).eliminarProducto(
                        index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(res
                          ? "Se elimino el produto correctamete"
                          : "No se pudo elimina el producto")),
                    );
                  },
                  child: cardProducto(theme, index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget cardProducto(ColorScheme theme, int index) {
    var productosFiltrados = ref
        .read(productosVMProvider)
        .productosFiltrados;

    return GestureDetector(
      onTap: () {
        context.go("/productos/updateProducto/${productosFiltrados[index].id}");
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Material(
          elevation: 8,
          color: theme.primary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.25,
                      child: Text(
                        "${productosFiltrados[index].id}",
                        style: TextStyle(color: theme.onPrimary, fontSize: 30),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.25,
                    child: Text(
                      "${productosFiltrados[index].nombre}",
                      style: TextStyle(color: theme.onPrimary, fontSize: 30),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.25,
                    child: Text(
                      "\$${productosFiltrados[index].precio!.toStringAsFixed(2)}",
                      style: TextStyle(color: theme.onPrimary, fontSize: 30),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.25,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "${productosFiltrados[index].stock}",
                        style: TextStyle(color: theme.onPrimary, fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//n.toStringAsFixed(2);

