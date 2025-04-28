import 'package:pos/core/dao/ProductoDAO.dart';

import '../../data/modelos/producto.dart';

class ProductoServicio{

  final ProductoDao productoRepositorio;

  ProductoServicio(this.productoRepositorio);

  //Devuelve la lista de todos los productos
  List<Producto> getAllProductos(){
    return productoRepositorio.getAllProductos();
  }

  //ingresa un nuevo producto a la base de datos, revisa si el nombre no existe, ya que no se pueden repetir.
  bool agregarProducto(String nombre, double precio, int stock){
    Producto producto = Producto(nombre, precio, stock);
    if(productoRepositorio.existeProductoPorNombre(nombre).isNotEmpty){
      return false;
    }
    return productoRepositorio.agregarProducto(producto);
  }

  //Elimina un producto de la lista por id.
  bool eliminarProducto(int idProducto){
    return productoRepositorio.eliminarProducto(idProducto);
  }

  //Obtiene un producto en especifico.
  Producto getProductoById(int idProducto){
    Producto? producto = productoRepositorio.getProductoById(idProducto);
    if(producto != null){
      return producto;
    }else{
      throw Exception("No se encontro el producto");
    }
  }

  //Actualiza un producto, revisa si el nombre ya existe, si es asi, comprueba que el id sea el mismo que se va a actualizar.
  bool updateProducto(Producto producto){
    List<Producto> productoPorNombre = productoRepositorio.existeProductoPorNombre(producto.nombre!);
    if(productoPorNombre.isNotEmpty){
      if(productoPorNombre[0].id != producto.id){
        return false;
      }
    }
    return productoRepositorio.updateProducto(producto);
  }
}