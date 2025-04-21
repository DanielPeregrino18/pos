

import 'package:pos/data/repositorios/ProductoDAOObjectboxImpl.dart';

import '../../data/modelos/producto.dart';

class ProductoServicio{

  ProductoDAOObjectboxImpl productoRepositorio = ProductoDAOObjectboxImpl();

  List<Producto> getAllProductos(){
    return productoRepositorio.getAllProductos();
  }

  //falta agregar validacion, si ya existe el nombre
  bool agregarProducto(String nombre, double precio, int stock){
    Producto producto = Producto(nombre, precio, stock);
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
      throw Exception("No se encoontro el producto");
    }
  }

  bool updateProducto(Producto producto){
    return productoRepositorio.agregarProducto(producto);
  }
}