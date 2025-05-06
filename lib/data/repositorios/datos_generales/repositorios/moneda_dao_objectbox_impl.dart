import 'package:pos/config/DB/ObjectboxConnection.dart';
import 'package:pos/core/dao/datos_generales/dao/moneda_dao.dart';
import 'package:pos/domain/entities/moneda.dart';
import 'package:pos/objectbox.g.dart';

class MonedaDaoObjectBoxImpl implements MonedaLDBDao {
  final ObjectboxConnection _connectionDB;
  MonedaDaoObjectBoxImpl(this._connectionDB);

  @override
  MonedaOB? getMonedaByIdLDB(int idMonedaOB) {
    final monedasLDB = _connectionDB.monedaBox;

    return monedasLDB.get(idMonedaOB);
  }

  @override
  List<MonedaOB> getAllMonedasLDB() {
    final monedasLDB = _connectionDB.monedaBox;
    return monedasLDB.getAll();
  }

  @override
  bool agregarMonedaLDB(MonedaOB monedaOB) {
    final monedasLDB = _connectionDB.monedaBox;
    try {
      monedasLDB.put(monedaOB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool eliminarMonedaLDB(int idMonedaOB) {
    final monedasLDB = _connectionDB.monedaBox;
    try {
      monedasLDB.remove(idMonedaOB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool updateMonedaLDB(MonedaOB monedaOB) {
    final monedasLDB = _connectionDB.monedaBox;
    try {
      monedasLDB.put(monedaOB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  List<MonedaOB> existeMonedaPorIdLDB(int monedaId) {
    final monedasLDB = _connectionDB.monedaBox;

    return monedasLDB
        .query(MonedaOB_.IdMoneda.equals(monedaId))
        .build()
        .find();
  }
}
