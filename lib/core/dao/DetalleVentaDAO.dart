

import 'package:pos/data/modelos/detalleVenta.dart';

//La estructura de los metodos para la conexion a la base de datos de ventas.
abstract class DetalleVentaDAO{

  DetalleVenta? getDetalleVentaPorID(int id);

  List<DetalleVenta> getAllDetallesVentas();

  int setDetalleVenta(DetalleVenta detalleVenta);
}