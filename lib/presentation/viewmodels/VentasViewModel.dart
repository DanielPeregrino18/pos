


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/servicios/DetalleVentaServicio.dart';
import 'package:pos/data/modelos/detalleVenta.dart';
import 'package:pos/data/modelos/producto.dart';

final ventasVMProvider = StateProvider<VentasViewModel>((ref) =>
                                      VentasViewModel(ref.read(detalleVentasServicioProvider)),);
class VentasViewModel extends ChangeNotifier{

  final DetalleVentaServicio detalleVentaServicio;
  List<DetalleVenta> todasLasVentas = [];

  VentasViewModel(this.detalleVentaServicio);


  List<DetalleVenta> getAllDetallesVentas(){
    todasLasVentas =  detalleVentaServicio.getAllDetallesVentas();

    return todasLasVentas;
  }

  List<MetodoPago> getMetodoPagoPorIndex(int index){
    return todasLasVentas[index].metodoPago.toList();
  }

  List<Map<String, dynamic>> getProductosPorIndex(int index){
    return todasLasVentas[index].productos.map((productoVenta) =>
    {"nombre":productoVenta.producto.target!.nombre,
      "cantidad" : productoVenta.cantidad,
      "precio": productoVenta.producto.target!.precio,
      "totalProducto": productoVenta.producto.target!.precio! * productoVenta.cantidad
    },).toList();
  }


}