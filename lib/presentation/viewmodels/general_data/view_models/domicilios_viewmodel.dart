import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/servicios/datos_generales/servicios/domicilios_servicio.dart';
import 'package:pos/domain/entities/domicilio.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';

class DomiciliosViewModel extends ChangeNotifier {
  final DomicilioServicio _domicilioServicio;

  DomiciliosViewModel(this._domicilioServicio);

  List<DomicilioOB> domicilios = [];

  List<DomicilioOB> domiciliosFiltrados = [];

  void getAllDomiciliosLDB() {
    domicilios = _domicilioServicio.getAllDomiciliosLDB();
    domiciliosFiltrados = domicilios;
  }

  void filtrarDomiciliosLDB(String value) {
    if (value.isEmpty) {
      domiciliosFiltrados = domicilios;
    } else {
      domiciliosFiltrados =
          domicilios
              .where(
                (domicilio) => domicilio.domicilio.toLowerCase().contains(
                  value.toLowerCase(),
                ),
              )
              .toList();
    }
    notifyListeners();
  }

  // Incluir funcionalidad para actualizar cierto domicilio

  bool agregarDomicilioLDB(DomicilioOB domicilioOB) {
    return _domicilioServicio.agregarDomicilioLDB(domicilioOB);
  }

  // Incluir funcionalidad para obtener el domicilio actualizado

  // Incluir funcionalidad para actualizar un domicilio
}

// Provider crud DomiciliosLDB

final domiciliosVMProvider = ChangeNotifierProvider(
  ((ref) => DomiciliosViewModel(ref.read(domiciliosServicioProvider))),
);

// Provider lista domicilios filtrada

final domiciliosFiltradosProv = StateProvider<List<DomicilioOB>>((ref) {
  final inputSearch = ref.watch(inputSearchProvider);
  final domicilios =
      ref.watch(domiciliosServicioProvider).getAllDomiciliosLDB();

  return domicilios
      .where(
        (domicilio) => domicilio.domicilio.toLowerCase().contains(
          inputSearch.toLowerCase(),
        ),
      )
      .toList();
});
