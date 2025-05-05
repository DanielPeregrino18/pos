import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/servicios/datos_generales/almacen_servicio.dart';
import 'package:pos/domain/entities/almacen.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';

class AlmacenesViewModel extends ChangeNotifier {
  List<AlmacenOB> almacenes = [];

  List<AlmacenOB> almacenesFiltrados = [];

  final AlmacenServicio _almacenServicio;

  AlmacenOB? almacenActualzado;

  AlmacenesViewModel(this._almacenServicio);

  void getAllAlmacenesLDB() {
    almacenes = _almacenServicio.getAllAlmacenesLDB();
    almacenesFiltrados = almacenes;
  }

  void filtrarAlmacenes(String value) {
    if (value.isEmpty) {
      almacenesFiltrados = almacenes;
    } else {
      almacenesFiltrados =
          almacenes
              .where(
                (almacen) =>
                    almacen.nombre.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  bool eliminarAlmacen(int indexAlmacenFiltrado) {
    int idAlmacenOB = almacenesFiltrados[indexAlmacenFiltrado].id;

    almacenesFiltrados.removeWhere(
      (almacenFiltrado) => almacenFiltrado.id == idAlmacenOB,
    );

    almacenes.removeWhere((almacen) => almacen.id == idAlmacenOB);

    return _almacenServicio.eliminarAlmacenLDB(idAlmacenOB);
  }

  bool agregarAlmacen(AlmacenOB almacenOB) {
    return _almacenServicio.agregarAlmacenLDB(almacenOB);
  }

  void getAlmacenActualizado(int idAlmacenOB) {
    almacenActualzado = _almacenServicio.getAlmacenByIdLDB(idAlmacenOB);
  }

  bool actualizarAlmacen(AlmacenOB almacenOB) {
    almacenActualzado = almacenOB;

    return _almacenServicio.updateAlmacen(almacenOB);
  }
}

// Provider crud almacenes
final almacenesVMProvider = ChangeNotifierProvider<AlmacenesViewModel>((ref) {
  return AlmacenesViewModel(ref.read(almacenServicioProvider));
});


// Almacenes filtrados provider

final almacenesFiltradosProv = StateProvider<List<AlmacenOB>>((ref) {
  final inputSearch = ref.watch(inputSearchProvider);
  final almacenes = ref.watch(almacenServicioProvider).getAllAlmacenesLDB();
  return almacenes
      .where(
        (almacenOB) =>
            almacenOB.nombre.toLowerCase().contains(inputSearch.toLowerCase()),
      )
      .toList();
});
