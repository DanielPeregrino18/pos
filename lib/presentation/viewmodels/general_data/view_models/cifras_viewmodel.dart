import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/servicios/datos_generales/servicios/cifras_servicio.dart';
import 'package:pos/domain/entities/cifras.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';
import 'package:pos/objectbox.g.dart';

class CifrasViewModel extends ChangeNotifier {
  final CifrasServicio _cifrasServicio;

  CifrasViewModel(this._cifrasServicio);

  List<CifrasOB> cifras = [];

  List<CifrasOB> cifrasFiltradas = [];

  CifrasOB? cifrasActualizadas;

  void getAllCifrasLDB() {
    cifras = _cifrasServicio.getAllCifrasLDB();
    cifrasFiltradas = cifras;
  }

  void filtrarCifras(String value) {
    if (value.isEmpty) {
      cifrasFiltradas = cifras;
    } else {
      cifrasFiltradas =
          cifras.where((cifra) => cifra.idMovC == int.parse(value)).toList();
    }
    notifyListeners();
  }

  bool eliminarCifras(int indexCifraFiltrada) {
    int idCifraOB = cifrasFiltradas[indexCifraFiltrada].id;

    cifrasFiltradas.removeWhere(
      (cifraFiltrada) => cifraFiltrada.id == idCifraOB,
    );

    cifras.removeWhere((cifras) => cifras.id == idCifraOB);

    return _cifrasServicio.eliminarCifrasLDB(idCifraOB);
  }

  bool agregarCifras(CifrasOB cifrasOB) {
    return _cifrasServicio.agregarCifrasLDB(cifrasOB);
  }

  void getCifrasActualizadas(int idCifrasOB) {
    cifrasActualizadas = _cifrasServicio.getAllCifrasLDB()[0];
  }

  bool actualizarCifras(CifrasOB cifrasOB) {
    cifrasActualizadas = cifrasOB;
    return _cifrasServicio.updateCifras(cifrasOB);
  }
}

// Provider crud cifras

final cifrasVMProvider = ChangeNotifierProvider(
  (ref) => CifrasViewModel(ref.read(cifrasServicioProvider)),
);

// Cifras filtrados provider

final cifrasFiltradasProv = StateProvider<List<CifrasOB>>((ref) {
  final inputSearch = ref.watch(inputSearchProvider);
  final listaCifras = ref.watch(cifrasServicioProvider).getAllCifrasLDB();
  return listaCifras
      .where((cifras) => CifrasOB_.idMovC == int.parse(inputSearch))
      .toList();
});
