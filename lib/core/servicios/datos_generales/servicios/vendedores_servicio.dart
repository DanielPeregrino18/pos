import 'package:pos/core/dao/datos_generales/datos_generales.dart';
import 'package:pos/domain/entities/entities.dart';

class VendedorServicio {
  final VendedorLDBDao vendedorRepositorio;

  VendedorServicio(this.vendedorRepositorio);

  List<VendedorOB> getAllVendedoresLDB() {
    return vendedorRepositorio.getAllVendedoresLDB();
  }

  bool agregarVendedorLDB(VendedorOB vendedorOB) {
    if (vendedorRepositorio
        .existeVendedorPorIdLDB(vendedorOB.id_Usuario)
        .isNotEmpty) {
      return false;
    }

    return vendedorRepositorio.agregarVendedorLDB(vendedorOB);
  }

  bool eliminarVendedorLDB(int idVendedorLDB) {
    return vendedorRepositorio.eliminarVendedorLDB(idVendedorLDB);
  }

  VendedorOB? getVendedorByIdLDB(int idVendedorOB) {
    VendedorOB? vendedorOB = vendedorRepositorio.getVendedorByIdLDB(
      idVendedorOB,
    );

    if (vendedorOB != null) {
      return vendedorOB;
    } else {
      throw Exception("Vendedor no encontrado");
    }
  }

  bool updateVendedor(VendedorOB vendedorOB) {
    List<VendedorOB> vendedorPorId = vendedorRepositorio.existeVendedorPorIdLDB(
      vendedorOB.id_Usuario,
    );

    if (vendedorPorId.isNotEmpty) {
      if (vendedorPorId[0].id != vendedorOB.id) {
        return false;
      }
    }

    return vendedorRepositorio.updateVendedorLDB(vendedorOB);
  }
}
