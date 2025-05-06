

import 'package:pos/config/DB/ObjectboxConnection.dart';
import 'package:pos/core/dao/datos_generales/dao/domicilio_dao.dart';
import 'package:pos/domain/entities/domicilio.dart';

class DomicilioDAOObjectBoxImpl extends DomicilioLDBDao {
  final ObjectboxConnection _connectionDB;

  DomicilioDAOObjectBoxImpl(this._connectionDB);

  // TODO: Implementar funcionalidad para obtener cierto Domicilio y para actualizarlo

  @override
  List<DomicilioOB> getAllDomiciliosLDB() {
    final domiciliosLDB = _connectionDB.domicilioBox;

    return domiciliosLDB.getAll();
  }

  @override
  bool agregarDomicilioLDB(DomicilioOB domicilioOB) {
    final domiciliosLDB = _connectionDB.domicilioBox;
    try {
      domiciliosLDB.put(domicilioOB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool eliminarDomicilioLDB(int idDomicilioOB) {
    final domiciliosLDB = _connectionDB.domicilioBox;
    try {
      domiciliosLDB.remove(idDomicilioOB);
      return true;
    } catch (e) {
      return false;
    }
  }
}