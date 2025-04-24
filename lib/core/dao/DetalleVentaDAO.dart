

import 'package:pos/data/modelos/detalleVenta.dart';

abstract class DetalleVentaDAO{

  DetalleVenta? getDetalleVentaPorID(int id);

  List<DetalleVenta> getAllDetallesVentas();

  int setDetalleVenta(DetalleVenta detalleVenta);
}