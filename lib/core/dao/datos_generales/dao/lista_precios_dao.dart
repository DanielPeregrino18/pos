import 'package:pos/domain/entities/lista_precios.dart';

// LDB = Local Database

abstract class ListaPreciosLDBDao {
  ListaPreciosOB? getListaPreciosByIdLDB(int idListaPrecios);

  List<ListaPreciosOB> getAllListaPreciosLDB();

  bool agregarListaPreciosLDB(ListaPreciosOB listaPrecios);

  bool eliminarListaPreciosLDB(int idListaPrecios);

  bool updateListaPreciosLDB(ListaPreciosOB listaPrecios);

  List<ListaPreciosOB> existeListaPreciosPorIdLDB(int listaPreciosId);
}
