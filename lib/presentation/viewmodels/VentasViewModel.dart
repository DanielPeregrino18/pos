


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/servicios/DetalleVentaServicio.dart';
import 'package:pos/data/modelos/detalleVenta.dart';
import 'package:pos/data/modelos/producto.dart';

//Maneja el estado de la pagina de ventas.
final ventasVMProvider = StateProvider<VentasViewModel>((ref) =>
                                      VentasViewModel(ref.read(detalleVentasServicioProvider)),);
class VentasViewModel extends ChangeNotifier{

  final DetalleVentaServicio detalleVentaServicio;
  List<DetalleVenta> todasLasVentas = [];

  VentasViewModel(this.detalleVentaServicio);


  //Obtiene todas las ventas que se han realizado.
  List<DetalleVenta> getAllDetallesVentas(){
    todasLasVentas =  detalleVentaServicio.getAllDetallesVentas();
    return todasLasVentas;
  }

  //Obtiene los metodos de pago de una venta en especifico (id)
  List<MetodoPago> getMetodoPagoPorIndex(int index){
    return todasLasVentas[index].metodoPago.toList();
  }

  //Obtiene los productos de una venta por medio del indice.
  List<Map<String, dynamic>> getProductosPorIndex(int index){
    return todasLasVentas[index].productos.map((productoVenta) =>
    {"nombre":productoVenta.producto.target!.nombre,
      "cantidad" : productoVenta.cantidad,
      "precio": productoVenta.producto.target!.precio,
      "totalProducto": productoVenta.producto.target!.precio! * productoVenta.cantidad
    },).toList();
  }


}