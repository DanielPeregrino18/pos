

import 'package:pos/core/dao/ProductoDAO.dart';

import '../../data/modelos/producto.dart';

class ProductoServicio{

  final ProductoDao productoRepositorio;

  ProductoServicio(this.productoRepositorio);

  List<Producto> getAllProductos(){
    return productoRepositorio.getAllProductos();
  }

  bool agregarProducto(String nombre, double precio, int stock){
    Producto producto = Producto(nombre, precio, stock);
    if(productoRepositorio.existeProductoPorNombre(nombre).isNotEmpty){
      return false;
    }
    return productoRepositorio.agregarProducto(producto);
  }

  bool eliminarProducto(int idProducto){
    return productoRepositorio.eliminarProducto(idProducto);
  }

  Producto getProductoById(int idProducto){
    Producto? producto =productoRepositorio.getProductoById(idProducto);
    if(producto != null){
      return producto;
    }else{
      throw Exception("No se encontro el producto");
    }
  }

  bool updateProducto(Producto producto){
    List<Producto> productoPorNombre = productoRepositorio.existeProductoPorNombre(producto.nombre!);
    if(productoPorNombre.isNotEmpty){
      if(productoPorNombre[0].id != producto.id){
        return false;
      }
    }
    return productoRepositorio.agregarProducto(producto);
  }
}