import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/servicios/datos_generales/datos_generales.dart';
import 'package:pos/domain/entities/vendedor.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';

class VendedoresViewModel extends ChangeNotifier {
  final VendedorServicio _vendedorServicio;

  VendedoresViewModel(this._vendedorServicio);

  List<VendedorOB> vendedores = [];

  List<VendedorOB> vendedoresFiltrados = [];

  VendedorOB? vendedorActualizado;

  void getAllVendedoresLDB() {
    vendedores = _vendedorServicio.getAllVendedoresLDB();
    vendedoresFiltrados = vendedores;
  }

  void filtrarVendedores(String value) {
    if (value.isEmpty) {
      vendedoresFiltrados = vendedores;
    } else {
      vendedoresFiltrados =
          vendedores
              .where(
                (vendedor) =>
                    vendedor.nombre.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  bool eliminarVendedor(int indexVendedorFiltrado) {
    int idVendedorOB = vendedoresFiltrados[indexVendedorFiltrado].id_Usuario;

    vendedoresFiltrados.removeWhere(
      (vendedorFiltrado) => vendedorFiltrado.id_Usuario == idVendedorOB,
    );

    vendedores.removeWhere((vendedor) => vendedor.id_Usuario == idVendedorOB);

    return _vendedorServicio.eliminarVendedorLDB(idVendedorOB);
  }

  bool agregarVendedor(VendedorOB vendedorOB) {
    return _vendedorServicio.agregarVendedorLDB(vendedorOB);
  }

  void getVendedorActualizado(int idVendedorOB) {
    vendedorActualizado = _vendedorServicio.getVendedorByIdLDB(idVendedorOB);
  }

  bool actualizarMoneda(VendedorOB vendedorOB) {
    vendedorActualizado = vendedorOB;
    return _vendedorServicio.updateVendedor(vendedorOB);
  }
}

// Provider crud vendedores
final vendedorVMProvider = ChangeNotifierProvider<VendedoresViewModel>(
  (ref) => VendedoresViewModel(ref.read(vendedoresServicioProvider)),
);

//Monedas filtradas provider
final vendedoresFiltradosProv = StateProvider<List<VendedorOB>>((ref) {
  final inputSearch = ref.watch(inputSearchProvider);
  final vendedores =
      ref.watch(vendedoresServicioProvider).getAllVendedoresLDB();
  return vendedores
      .where(
        (vendedor) =>
            vendedor.nombre.toLowerCase().contains(inputSearch.toLowerCase()),
      )
      .toList();
});
