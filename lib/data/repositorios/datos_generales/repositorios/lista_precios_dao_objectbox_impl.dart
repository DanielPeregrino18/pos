import 'package:pos/config/DB/ObjectboxConnection.dart';
import 'package:pos/core/dao/datos_generales/dao/lista_precios_dao.dart';
import 'package:pos/domain/entities/lista_precios.dart';
import 'package:pos/objectbox.g.dart';

class ListaPreciosDAOObjectBoxImpl extends ListaPreciosLDBDao {
  final ObjectboxConnection _connectionDB;

  ListaPreciosDAOObjectBoxImpl(this._connectionDB);

  @override
  ListaPreciosOB? getListaPreciosByIdLDB(int idListaPrecios) {
    final listaPreciosLDB = _connectionDB.listaPreciosBox;

    return listaPreciosLDB.get(idListaPrecios);
  }

  @override
  List<ListaPreciosOB> getAllListaPreciosLDB() {
    final listaPreciosLDB = _connectionDB.listaPreciosBox;

    return listaPreciosLDB.getAll();
  }

  @override
  bool agregarListaPreciosLDB(ListaPreciosOB listaPrecios) {
    final listaPreciosLDB = _connectionDB.listaPreciosBox;
    try {
      listaPreciosLDB.put(listaPrecios);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool eliminarListaPreciosLDB(int idListaPrecios) {
    final listaPreciosLDB = _connectionDB.listaPreciosBox;
    try {
      listaPreciosLDB.remove(idListaPrecios);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool updateListaPreciosLDB(ListaPreciosOB listaPrecios) {
    final listaPreciosLDB = _connectionDB.listaPreciosBox;
    try {
      listaPreciosLDB.put(listaPrecios);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  List<ListaPreciosOB> existeListaPreciosPorIdLDB(int listaPreciosId) {
    final listaPreciosLDB = _connectionDB.listaPreciosBox;
    return listaPreciosLDB
        .query(ListaPreciosOB_.id.equals(listaPreciosId))
        .build()
        .find();
  }
}
