import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/servicios/datos_generales/servicios/lista_precios_servicio.dart';
import 'package:pos/domain/entities/lista_precios.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';

class ListaPreciosViewModel extends ChangeNotifier {
  final ListaPreciosServicio _listaPreciosServicio;

  ListaPreciosViewModel(this._listaPreciosServicio);

  List<ListaPreciosOB> precios = [];

  List<ListaPreciosOB> preciosFiltrados = [];

  ListaPreciosOB? precioActualizado;

  void getAllPreciosLDB() {
    precios = _listaPreciosServicio.getAllListaPreciosLDB();
    preciosFiltrados = precios;
  }

  void filtrarPreciosLDB(String value) {
    if (value.isEmpty) {
      preciosFiltrados = precios;
    } else {
      preciosFiltrados =
          precios
              .where(
                (precio) =>
                    precio.NOMBRE.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  bool eliminarPrecioLDB(int indexListaPreciosFiltrado) {
    int idListaPreciosOB = preciosFiltrados[indexListaPreciosFiltrado].ID_LISTA;

    preciosFiltrados.removeWhere(
      (precioFiltrado) => precioFiltrado.ID_LISTA == idListaPreciosOB,
    );

    precios.removeWhere((precio) => precio.ID_LISTA == idListaPreciosOB);

    return _listaPreciosServicio.eliminarListaPreciosLDB(idListaPreciosOB);
  }

  bool agregarPrecioLDB(ListaPreciosOB listaPreciosOB) {
    return _listaPreciosServicio.agregarListaPreciosLDB(listaPreciosOB);
  }

  void getLPrecioActualizadoLDB(int idListaPreciosOB) {
    precioActualizado = _listaPreciosServicio.getListaPreciosByIdLDB(
      idListaPreciosOB,
    );
  }

  bool actualizarPrecioLDB(ListaPreciosOB listaPreciosOB) {
    precioActualizado = listaPreciosOB;
    return _listaPreciosServicio.updateListaPrecios(listaPreciosOB);
  }
}

// Provider crud precios

final listaPreciosVMProvider = ChangeNotifierProvider(
  (ref) => ListaPreciosViewModel(ref.read(listaPreciosServicioProvider)),
);

// Provider lista de precios filtrada

final listaPreciosFiltradaProv = StateProvider<List<ListaPreciosOB>>((ref) {
  final inputSearch = ref.watch(inputSearchProvider);
  final listaPrecios =
      ref.watch(listaPreciosServicioProvider).getAllListaPreciosLDB();

  return listaPrecios
      .where(
        (listaPrecio) => listaPrecio.NOMBRE.toLowerCase().contains(
          inputSearch.toLowerCase(),
        ),
      )
      .toList();
});
