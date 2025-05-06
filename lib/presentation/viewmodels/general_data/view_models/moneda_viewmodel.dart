import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/servicios/datos_generales/servicios/moneda_servicio.dart';
import 'package:pos/domain/entities/entities.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';

class MonedasViewModel extends ChangeNotifier {
  final MonedaServicio _monedaServicio;

  MonedasViewModel(this._monedaServicio);

  List<MonedaOB> monedas = [];

  List<MonedaOB> monedasFiltradas = [];

  MonedaOB? monedaActualizada;

  void getAllMonedasLDB() {
    monedas = _monedaServicio.getAllMonedasLDB();
    monedasFiltradas = monedas;
  }

  void filtrarMonedas(String value) {
    if (value.isEmpty) {
      monedasFiltradas = monedas;
    } else {
      monedasFiltradas =
          monedas
              .where(
                (moneda) =>
                    moneda.Nombre.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  bool eliminarMoneda(int indexMonedaFiltrada) {
    int idMonedaOB = monedasFiltradas[indexMonedaFiltrada].IdMoneda;

    monedasFiltradas.removeWhere(
      (monedaFiltrada) => monedaFiltrada.IdMoneda == idMonedaOB,
    );

    monedas.removeWhere((moneda) => moneda.IdMoneda == idMonedaOB);

    return _monedaServicio.eliminarMonedaLDB(idMonedaOB);
  }

  bool agregarMoneda(MonedaOB monedaOB) {
    return _monedaServicio.agregarMonedaLDB(monedaOB);
  }

  void getMonedaActualizada(int idMonedaOB) {
    monedaActualizada = _monedaServicio.getMonedaByIdLDB(idMonedaOB);
  }

  bool actualizarMoneda(MonedaOB monedaOB) {
    monedaActualizada = monedaOB;
    return _monedaServicio.updateMoneda(monedaOB);
  }
}

// Provider crud moneda
final monedaVMProvider = ChangeNotifierProvider<MonedasViewModel>(
  (ref) => MonedasViewModel(ref.read(monedaServicioProvider)),
);

// Monedas filtradas provider
final monedasFiltradasProv = StateProvider<List<MonedaOB>>((ref) {
  final inputSearch = ref.watch(inputSearchProvider);
  final monedas = ref.watch(monedaServicioProvider).getAllMonedasLDB();
  return monedas
      .where(
        (moneda) =>
            moneda.Nombre.toLowerCase().contains(inputSearch.toLowerCase()),
      )
      .toList();
});
