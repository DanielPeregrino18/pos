import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/servicios/ProductoServicio.dart';
import 'package:pos/presentation/viewmodels/ProductosViewModel.dart';

class AddProducto extends ConsumerStatefulWidget {
  const AddProducto({Key? key}) : super(key: key);

  @override
  ConsumerState<AddProducto> createState() => _AddProductoState();
}

class _AddProductoState extends ConsumerState<AddProducto> {
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
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 50,
                    children: [
                      TextFormField(
                        controller: _nombre,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: theme.primary)
                            ),
                            prefixIcon: Icon(Icons.fiber_new_rounded, color: theme.primary, size: 50.sp,),
                            labelText: "Nombre del Producto",
                            labelStyle: TextStyle(color: theme.primary, fontSize: 40.sp),
                        ),
                        style: TextStyle(fontSize: 50.sp),
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
                          prefixIcon: Icon(Icons.attach_money, color: theme.primary, size: 50.sp,),
                          labelText: "Precio del producto",
                          labelStyle: TextStyle(color: theme.primary, fontSize: 40.sp),
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]')),],
                        style: TextStyle(fontSize: 50.sp),
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
                          prefixIcon: Icon(Icons.numbers, color: theme.primary, size: 50.sp,),
                          labelText: "Stock inicial",
                          labelStyle: TextStyle(color: theme.primary, fontSize: 40.sp),
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
                        style: TextStyle(fontSize: 50.sp),
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
                          bool res = ref.read(productosVMProvider).agregarProducto(_nombre.text, double.parse(_precio.text), int.parse(_stock.text));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(res ? "Se agrego el produto ${_nombre.text}":"No se pudo agregar el producto")),
                          );
                        }
                      }, style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50)
                      ), child: Text("Agregar Producto", style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),))
                    ],
                  ),
                )
            ),
        ),
      ),

    );
  }

}
