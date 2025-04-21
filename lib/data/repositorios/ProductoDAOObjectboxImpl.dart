

import 'package:pos/config/ObjectboxConnection.dart';
import 'package:pos/core/dao/ProductoDAO.dart';

import '../../objectbox.g.dart';
import '../modelos/producto.dart';
class ProductoDAOObjectboxImpl implements ProductoDao{

  Box<Producto> productoDB = ObjectboxConnection.produtoBox;

  @override
  Producto? getProductoById(int idProducto){
    return productoDB.get(idProducto);
  }

  @override
  List<Producto> getAllProductos(){
    return productoDB.getAll();
  }

  @override
  bool agregarProducto(Producto producto){
    try{
      productoDB.put(producto);
      return true;
    }catch(e){
      return false;
    }
  }

  @override
  bool eliminarProducto(int idProducto){
    try {
      productoDB.remove(idProducto);
      return true;
    }catch (e){
      return false;
    }
  }


  @override
  bool updateProducto(Producto producto){
    try{
      productoDB.put(producto);
      return true;
    }catch(e){
      return false;
    }
  }
}