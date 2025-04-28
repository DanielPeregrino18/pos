
import 'package:pos/data/modelos/producto.dart';

//La estructura de los metodos para la conexion a la base de datos de Productos.
abstract class ProductoDao{

  //Regresa el producto que coincida con el id.
  Producto? getProductoById(int idProducto);

  //Regresa todos los productos almacenados.
  List<Producto> getAllProductos();

  // Agrega un producto, devuelve true si se completo correctamente.

  bool agregarProducto(Producto producto);

  //Elimina un producto que coincida con el id del parametro, regresa true si se completo la accion.
  bool eliminarProducto(int idProducto);

  //Actualiza el producto que coincida con el id ingresado.
  bool updateProducto(Producto producto);

  //Obtiene un producto por su nombre.
  List<Producto> existeProductoPorNombre(String nombre);


}