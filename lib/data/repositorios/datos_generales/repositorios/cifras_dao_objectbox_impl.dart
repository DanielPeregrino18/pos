import 'package:pos/config/DB/ObjectboxConnection.dart';
import 'package:pos/core/dao/datos_generales/dao/cifras_dao.dart';
import 'package:pos/domain/entities/cifras.dart';
import 'package:pos/objectbox.g.dart';

class CifrasDAOOBjectboxImpl extends CifrasLDBDao {
  final ObjectboxConnection _connectionDB;

  CifrasDAOOBjectboxImpl(this._connectionDB);

  @override
  List<CifrasOB> getAllCifrasLDB() {
    final cifrasLDB = _connectionDB.cifrasBox;

    return cifrasLDB.getAll();
  }

  @override
  bool agregarCifrasLDB(CifrasOB cifrasOB) {
    final cifrasLDB = _connectionDB.cifrasBox;

    try {
      cifrasLDB.put(cifrasOB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool eliminarCifrasLDB(int cifrasId) {
    final cifrasLDB = _connectionDB.cifrasBox;

    try {
      cifrasLDB.remove(cifrasId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool updateCifrasLDB(CifrasOB cifrasOB) {
    final cifrasLDB = _connectionDB.cifrasBox;

    try {
      cifrasLDB.put(cifrasOB);
      return true;
    } catch (e) {
      return false;
    }
  }
}
