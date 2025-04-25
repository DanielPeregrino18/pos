import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/servicios/ProductoServicio.dart';
import 'package:pos/presentation/viewmodels/ProductosViewModel.dart';

import '../../../data/modelos/producto.dart';

class UpdateProducto extends ConsumerStatefulWidget {
  final String? id;
  const UpdateProducto({super.key, this.id});

  @override
  ConsumerState<UpdateProducto> createState() => _UpdateProductoState();
}

class _UpdateProductoState extends ConsumerState<UpdateProducto> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nombre;
  TextEditingController? _precio;
  TextEditingController? _stock;

  @override
  void initState() {
    super.initState();
    ref.read(productosVMProvider).getProductoActualizando(widget.id!);
    _nombre = TextEditingController(
      text: ref.read(productosVMProvider).productoActualizando!.nombre!,
    );
    _precio = TextEditingController(
      text: "${ref.read(productosVMProvider).productoActualizando!.precio}",
    );
    _stock = TextEditingController(
      text: "${ref.read(productosVMProvider).productoActualizando!.stock}",
    );
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
                    bool res = ref
                        .read(productosVMProvider)
                        .actualizarProducto(
                          _nombre!.text,
                          _precio!.text,
                          _stock!.text,
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          res
                              ? "Se actualizo el produto ${ref.read(productosVMProvider).productoActualizando!.nombre}"
                              : "No se pudo actualizar el producto",
                        ),
                      ),
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
}
