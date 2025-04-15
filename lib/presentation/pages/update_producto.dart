import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/servicios/ProductoServicio.dart';

import '../../data/modelos/producto.dart';

class UpdateProducto extends StatefulWidget {
  final String? id;
  const UpdateProducto({super.key, this.id});

  @override
  _UpdateProductoState createState() => _UpdateProductoState();
}

class _UpdateProductoState extends State<UpdateProducto>
    with AfterLayoutMixin<UpdateProducto> {
  Producto? producto;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombre;
  late final TextEditingController _precio;
  late final TextEditingController _stock;
  @override
  void initState() {
    super.initState();
    ProductoServicio productoServicio = ProductoServicio();
    try {
      producto = productoServicio.getProductoById(int.parse(widget.id!));
    } catch (e) {
      producto = Producto("", 0.0, 0);
    }
    _nombre = TextEditingController(text: producto!.nombre);
    _precio = TextEditingController(text: "${producto!.precio}");
    _stock = TextEditingController(text: "${producto!.stock}");
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Text(
          "Actualizar Producto",
          style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.onPrimary),
        backgroundColor: theme.primary,
        leading: IconButton(
          onPressed: () {
              context.pop();
              context.push("/productos");
          },
          icon: Icon(Icons.arrow_back),
        ),
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
                    borderSide: BorderSide(color: theme.primary),
                  ),
                  prefixIcon: Icon(
                    Icons.fiber_new_rounded,
                    color: theme.primary,
                    size: 40,
                  ),
                  labelText: "Nombre del Producto",
                  labelStyle: TextStyle(color: theme.primary, fontSize: 30),
                ),
                style: TextStyle(fontSize: 30),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El nombre no puede estar vacio";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precio,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.primary),
                  ),
                  prefixIcon: Icon(
                    Icons.attach_money,
                    color: theme.primary,
                    size: 40,
                  ),
                  labelText: "Precio del producto",
                  labelStyle: TextStyle(color: theme.primary, fontSize: 30),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                ],
                style: TextStyle(fontSize: 30),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "No puede estar vacio.";
                  } else if (value.split(".").length > 2) {
                    return "Formato invalido.";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stock,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.primary),
                  ),
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: theme.primary,
                    size: 40,
                  ),
                  labelText: "Stock inicial",
                  labelStyle: TextStyle(color: theme.primary, fontSize: 30),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                style: TextStyle(fontSize: 30),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "No puede estar vacio.";
                  } else if (int.parse(value) <= 0) {
                    return "Debe contener stock inicial.";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _agregarProducto(
                      _nombre.text,
                      double.parse(_precio.text),
                      int.parse(_stock.text),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "Actualizar Producto",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    if (producto!.precio == 0.0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No se encontro el producto.")));
    }
  }

  void _agregarProducto(String nombre, double precio, int stock) {
    ProductoServicio productoServicio = ProductoServicio();
    producto!.nombre = nombre;
    producto!.precio = precio;
    producto!.stock = stock;
    bool res = productoServicio.updateProducto(producto!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          res
              ? "Se actualizo el produto $nombre"
              : "No se pudo actualizar el producto",
        ),
      ),
    );
  }
}
