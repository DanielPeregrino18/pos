import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/servicios/ProductoServicio.dart';
import '../../data/modelos/producto.dart';

final productosVMProvider = ChangeNotifierProvider<ProductosViewModel>(
  (ref) => ProductosViewModel(ref.read(productoServicioProvider)),
);

class ProductosViewModel extends ChangeNotifier {
  //MOSTRAR PRODUCTOS
  List<Producto> productosVenta = [];
  List<Producto> productosFiltrados = [];

  //ACTUALIZACION DE PRODUCTO
  final ProductoServicio _productoServicio;
  Producto? productoActualizando;

  ProductosViewModel(this._productoServicio);

  //MOSTRAR PRODUCTOS
  void getAllProductos() {
    productosVenta = _productoServicio.getAllProductos();
    productosFiltrados = productosVenta;
  }

  void filtrarProductos(String value) {
    if (value.isEmpty) {
      productosFiltrados = productosVenta;
    } else {
      productosFiltrados =
          productosVenta
              .where(
                (prod) =>
                    prod.nombre!.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();
    }
  }

  //ELIMINAR PRODUCTO
  bool eliminarProducto(int indexProductoFiltrado){
    int idProducto = productosFiltrados[indexProductoFiltrado].id;
    productosFiltrados.removeWhere((prodFiltrado) => prodFiltrado.id == idProducto,);
    productosVenta.removeWhere((prodVenta) => prodVenta.id == idProducto,);
    return _productoServicio.eliminarProducto(idProducto);

  }
  //AGREGAR PRODUCTO
  bool agregarProducto(String nombre, double precio, int stock) {
    return _productoServicio.agregarProducto(nombre, precio, stock);
  }

  //ACTUALIZACION DE PRODUCTO
  void getProductoActualizando(String idProducto) {
    productoActualizando = _productoServicio.getProductoById(
      int.parse(idProducto),
    );
  }

  bool actualizarProducto(String nombre, String precio, String stock) {
    productoActualizando!.nombre = nombre;
    productoActualizando!.precio = double.parse(precio);
    productoActualizando!.stock = int.parse(stock);
    return _productoServicio.updateProducto(productoActualizando!);
  }
}
