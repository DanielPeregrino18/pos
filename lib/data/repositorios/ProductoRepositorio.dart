

import 'package:pos/config/ObjectboxConnection.dart';

import '../../objectbox.g.dart';
import '../modelos/producto.dart';
class ProductoRepositorio {

  Box<Producto> productoDB = ObjectboxConnection.produtoBox;

  List<Producto> getAllProductos(){
    return productoDB.getAll();
  }

  bool agregarProducto(Producto producto){
    try{
      productoDB.put(producto);
      return true;
    }catch(e){
      return false;
    }
  }

  bool eliminarProducto(int idProducto){
    try {
      productoDB.remove(idProducto);
      return true;
    }catch (e){
      return false;
    }
  }

  Producto? getProductoById(int idProducto){
    return productoDB.get(idProducto);
  }

  bool updateProducto(Producto producto){
    try{
      productoDB.put(producto);
      return true;
    }catch(e){
      return false;
    }
  }
}