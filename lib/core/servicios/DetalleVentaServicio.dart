
import 'package:pos/core/dao/DetalleVentaDAO.dart';
import 'package:pos/core/servicios/ProductoServicio.dart';
import 'package:pos/data/modelos/producto.dart';

import '../../data/modelos/detalleVenta.dart';
import '../../data/modelos/formaPago.dart';

class DetalleVentaServicio{

  final DetalleVentaDAO detalleVentaRepositorio;
  final ProductoServicio productoServicio;

  DetalleVentaServicio(this.detalleVentaRepositorio, this.productoServicio);

  //Obtiene una venta con un id especifico.
  DetalleVenta getDetalleVentaPorID(int id){
    return detalleVentaRepositorio.getDetalleVentaPorID(id)!;
  }

  //Devuelve la lista de ventas realizadas, por id de mayor a menor.
  List<DetalleVenta> getAllDetallesVentas(){
    return detalleVentaRepositorio.getAllDetallesVentas().reversed.toList();
  }

  //Guarda una venta en la base de datos y disminuye el stock de los productos vendidos.
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

    //Disminuye la cantidad del stock de los productos vendidos
    productosCantidades.forEach((productoCantidad) {
      Producto producto = productoCantidad["producto"];
      producto.stock = (producto.stock - productoCantidad["cantidad"]) as int;
      productoServicio.updateProducto(producto);
    },);

    return detalleVentaRepositorio.setDetalleVenta(detalleVenta);
  }

}