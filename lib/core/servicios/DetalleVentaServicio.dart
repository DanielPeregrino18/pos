
import 'package:pos/core/dao/DetalleVentaDAO.dart';
import 'package:pos/data/modelos/producto.dart';

import '../../data/modelos/detalleVenta.dart';
import '../../data/modelos/formaPago.dart';

class DetalleVentaServicio{

  final DetalleVentaDAO detalleVentaRepositorio;

  DetalleVentaServicio(this.detalleVentaRepositorio);

  DetalleVenta getDetalleVentaPorID(int id){
    return detalleVentaRepositorio.getDetalleVentaPorID(id)!;
  }

  List<DetalleVenta> getAllDetallesVentas(){
    return detalleVentaRepositorio.getAllDetallesVentas().reversed.toList();
  }

  //falta bajar el stock
  int setDetalleVenta(List<Map<String, dynamic>> productosCantidades, List<FormaPago> formasDePago, double total, double cambio){
    DetalleVenta detalleVenta = DetalleVenta(DateTime.now(), total, cambio);
    //agrega las formas de pago
    formasDePago.forEach((formaPago) {
      detalleVenta.metodoPago.add(MetodoPago(formaPago.tipo, formaPago.index, formaPago.cantidad));
    },);

    //agrega los productos y las cantidades
    productosCantidades.forEach((productoCantidad) {
      final productoVenta = ProductoVenta(productoCantidad["cantidad"]);
      productoVenta.producto.target = productoCantidad["producto"];
      detalleVenta.productos.add(productoVenta);
    },);

    return detalleVentaRepositorio.setDetalleVenta(detalleVenta);
  }

  //se usa para mostrar la información de la venta en un ticket y pagina de ventas

}