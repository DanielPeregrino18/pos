import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/servicios/ProductoServicio.dart';
import 'package:pos/data/modelos/producto.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';

class Productos extends StatefulWidget {
  const Productos({Key? key}) : super(key: key);

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  List<Producto>? productosVenta;
  int num = 0;
  ProductoServicio? productoServicio;
  List<Producto> productosFiltrados = [];

  @override
  void initState() {
    productoServicio = ProductoServicio();
    productosVenta = productoServicio!.getAllProductos();
    setState(() {
      productosFiltrados = productosVenta!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    void filtro(String value) {
      setState(() {
        if (value.isEmpty) {
          productosFiltrados = productosVenta!;
        } else {
          productosFiltrados =
              productosVenta!
                  .where(
                    (prod) => prod.nombre!.toLowerCase().contains(
                      value.toLowerCase(),
                    ),
                  )
                  .toList();
        }
      });
    }

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
              filtro(value);
            },
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        "ID Producto",
                        style: TextStyle(color: theme.primary, fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Text(
                      "Nombre",
                      style: TextStyle(color: theme.primary, fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Text(
                      "Precio",
                      style: TextStyle(color: theme.primary, fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Text(
                      "Existencias",
                      style: TextStyle(color: theme.primary, fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productosFiltrados.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: backgroundCard(),
                  onDismissed: (direction) {
                    int idDelete = productosVenta!.indexWhere(
                      (prod) => prod.id == productosFiltrados[index].id,
                    );
                    setState(() {
                      _eliminarProducto(productosFiltrados[index].id, productosFiltrados[index].nombre!);
                      productosVenta!.removeAt(idDelete);
                      if(productosVenta != productosFiltrados){
                        productosFiltrados.removeAt(index);
                      }
                    });
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

  Container backgroundCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(Icons.delete),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  Widget cardProducto(ColorScheme theme, int index) {
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
                      width: MediaQuery.of(context).size.width * 0.25,
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
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Text(
                      "${productosFiltrados[index].nombre}",
                      style: TextStyle(color: theme.onPrimary, fontSize: 30),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Text(
                      "${format(productosFiltrados[index].precio!)}\$",
                      style: TextStyle(color: theme.onPrimary, fontSize: 30),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
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

  void _eliminarProducto(int id, String nombre) {
    ProductoServicio productoServicio = ProductoServicio();
    bool res = productoServicio.eliminarProducto(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(res ? "Se elimino el produto $nombre":"No se pudo elimina el producto")),
    );
  }
}

String format(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}
