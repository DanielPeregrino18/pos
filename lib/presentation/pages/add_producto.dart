import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/servicios/ProductoServicio.dart';

class AddProducto extends StatefulWidget {
  const AddProducto({Key? key}) : super(key: key);

  @override
  _AddProductoState createState() => _AddProductoState();
}

class _AddProductoState extends State<AddProducto> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _precio = TextEditingController();
  final TextEditingController _stock = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Text(
          "Agregar Producto",
          style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.onPrimary),
        backgroundColor: theme.primary,
        leading: IconButton(onPressed: () {
          context.pop();
          context.push("/productos");
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Form(
        key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 40,
              children: [
                TextFormField(
                  controller: _nombre,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: theme.primary)
                      ),
                      prefixIcon: Icon(Icons.fiber_new_rounded, color: theme.primary, size: 40,),
                      labelText: "Nombre del Producto",
                      labelStyle: TextStyle(color: theme.primary, fontSize: 30),
                  ),
                  style: TextStyle(fontSize: 30),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "El nombre no puede estar vacio";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _precio,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: theme.primary)
                    ),
                    prefixIcon: Icon(Icons.attach_money, color: theme.primary, size: 40,),
                    labelText: "Precio del producto",
                    labelStyle: TextStyle(color: theme.primary, fontSize: 30),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]')),],
                  style: TextStyle(fontSize: 30),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "No puede estar vacio.";
                    }else if (value.split(".").length > 2) {
                      return "Formato invalido.";
                    }
                    return null;
                  },

                ),
                TextFormField(
                  controller: _stock,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: theme.primary)
                    ),
                    prefixIcon: Icon(Icons.numbers, color: theme.primary, size: 40,),
                    labelText: "Stock inicial",
                    labelStyle: TextStyle(color: theme.primary, fontSize: 30),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
                  style: TextStyle(fontSize: 30),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "No puede estar vacio.";
                    }else if (int.parse(value) <= 0) {
                      return "Debe contener stock inicial.";
                    }
                    return null;
                  },
                ),
                ElevatedButton(onPressed: () {
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    _agregarProducto(_nombre.text, double.parse(_precio.text), int.parse(_stock.text));
                  }
                }, style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50)
                ), child: Text("Agregar Producto", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
              ],
            ),
          )
      ),
    );
  }

  void _agregarProducto(String nombre, double precio, int stock) {
    ProductoServicio productoServicio = ProductoServicio();
    bool res = productoServicio.agregarProducto(nombre, precio, stock);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(res ? "Se agrego el produto $nombre":"No se pudo agregar el producto")),
    );
  }
}
