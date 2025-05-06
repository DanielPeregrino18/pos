import 'package:pos/config/DB/ObjectboxConnection.dart';
import 'package:pos/core/dao/datos_generales/dao/vendedor_dao.dart';
import 'package:pos/domain/entities/vendedor.dart';
import 'package:pos/objectbox.g.dart';

class VendedorDAOObjectboxImpl extends VendedorLDBDao {
  final ObjectboxConnection _connectionDB;

  VendedorDAOObjectboxImpl(this._connectionDB);

  @override
  VendedorOB? getVendedorByIdLDB(int idVendedorOB) {
    final vendedoresLDB = _connectionDB.vendedorBox;

    return vendedoresLDB.get(idVendedorOB);
  }

  @override
  List<VendedorOB> getAllVendedoresLDB() {
    final vendedoresLDB = _connectionDB.vendedorBox;

    return vendedoresLDB.getAll();
  }

  @override
  bool agregarVendedorLDB(VendedorOB vendedorOB) {
    final vendedoresLDB = _connectionDB.vendedorBox;

    try {
      vendedoresLDB.put(vendedorOB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool eliminarVendedorLDB(int idVendedorLDB) {
    final vendedoresLDB = _connectionDB.vendedorBox;

    try {
      vendedoresLDB.remove(idVendedorLDB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool updateVendedorLDB(VendedorOB vendedorOB) {
    final vendedoresLDB = _connectionDB.vendedorBox;

    try {
      vendedoresLDB.put(vendedorOB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  List<VendedorOB> existeVendedorPorIdLDB(int idVendedorOB) {
    final vendedoresLDB = _connectionDB.vendedorBox;
    return vendedoresLDB
        .query(VendedorOB_.id_Usuario.equals(idVendedorOB))
        .build()
        .find();
  }
}
