

import 'package:pos/config/DB/ObjectboxConnection.dart';
import 'package:pos/core/dao/ProductoDAO.dart';
import '../../objectbox.g.dart';
import '../modelos/producto.dart';

//Implementacion de ProductoDAO utilizando ObjectBox
class ProductoDAOObjectboxImpl extends ProductoDao{
  final ObjectboxConnection _connectionDB;

  ProductoDAOObjectboxImpl(this._connectionDB);


  @override
  Producto? getProductoById(int idProducto){
    final productoDB = _connectionDB.produtoBox;
    return productoDB.get(idProducto);
  }

  @override
  List<Producto> getAllProductos(){
    final productoDB = _connectionDB.produtoBox;
    return productoDB.getAll();
  }

  @override
  bool agregarProducto(Producto producto){
    final productoDB = _connectionDB.produtoBox;
    try{
      productoDB.put(producto);
      return true;
    }catch(e){
      return false;
    }
  }

  @override
  bool eliminarProducto(int idProducto){
    final productoDB = _connectionDB.produtoBox;
    try {
      productoDB.remove(idProducto);
      return true;
    }catch (e){
      return false;
    }
  }

  @override
  bool updateProducto(Producto producto){
    final productoDB = _connectionDB.produtoBox;
    try{
      productoDB.put(producto);
      return true;
    }catch(e){
      return false;
    }
  }

  @override
  List<Producto> existeProductoPorNombre(String nombre) {
    final productoDB = _connectionDB.produtoBox;
    Query<Producto> query = productoDB.query(Producto_.nombre.equals(nombre)).build();
    return query.find();
  }

}