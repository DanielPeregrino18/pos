import 'package:pos/core/dao/datos_generales/dao/lista_precios_dao.dart';
import 'package:pos/domain/entities/entities.dart';

class ListaPreciosServicio {
  final ListaPreciosLDBDao listaPreciosRepositorio;

  ListaPreciosServicio(this.listaPreciosRepositorio);

  List<ListaPreciosOB> getAllListaPreciosLDB() {
    return listaPreciosRepositorio.getAllListaPreciosLDB();
  }

  bool agregarListaPreciosLDB(ListaPreciosOB listaPreciosOB) {
    if (listaPreciosRepositorio
        .existeListaPreciosPorIdLDB(listaPreciosOB.ID_LISTA)
        .isNotEmpty) {
      return false;
    }
    return listaPreciosRepositorio.agregarListaPreciosLDB(listaPreciosOB);
  }

  bool eliminarListaPreciosLDB(int idListaPreciosOB) {
    return listaPreciosRepositorio.eliminarListaPreciosLDB(idListaPreciosOB);
  }

  ListaPreciosOB? getListaPreciosByIdLDB(int idListaPreciosOB) {
    ListaPreciosOB? listaPreciosOB = listaPreciosRepositorio
        .getListaPreciosByIdLDB(idListaPreciosOB);
    if (listaPreciosOB != null) {
      return listaPreciosOB;
    } else {
      throw Exception("Precio no encontrado");
    }
  }

  bool updateListaPrecios(ListaPreciosOB listaPreciosOB) {
    List<ListaPreciosOB> listaPreciosPorId = listaPreciosRepositorio
        .existeListaPreciosPorIdLDB(listaPreciosOB.id);

    if (listaPreciosPorId.isNotEmpty) {
      if (listaPreciosPorId[0].id != listaPreciosOB.id) {
        return false;
      }
    }

    return listaPreciosRepositorio.updateListaPreciosLDB(listaPreciosOB);
  }
}
