import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/data/modelos/Venta.dart';

final reporteVentasVMProvider = ChangeNotifierProvider<ReporteVentasVM>(
  (ref) => ReporteVentasVM(ref.read(ventasApiProvider)),
);

class ReporteVentasVM extends ChangeNotifier {
  DateTime fechaInicio = DateTime.now();
  DateTime fechaFin = DateTime.now();
  VentaApi ventaApi;
  List<Venta> ventasMostradas = [];
  List<Venta> allVentas = [];
  final ventasPorPagina = 10;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  ReporteVentasVM(this.ventaApi);

  Future obtenerVentas() async {
    allVentas = await ventaApi.login(
      "19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df",
      2,
      10,
      formatter.format(fechaInicio),
      formatter.format(fechaFin),
      1,
      1,
      2,
      "",
      0,
      false,
    );
    ventasMostradas = [];
    await cargarMas();
  }

  Future cargarMas() async{
    int iteraciones = min(ventasPorPagina, allVentas.length);
    await Future.delayed(Duration(seconds: 2), () {
      for(int i = 0; i < iteraciones; i++){
        ventasMostradas.add(allVentas.removeAt(0));
      }
    });
    notifyListeners();
  }
}
