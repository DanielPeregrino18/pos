import 'package:pos/domain/entities/domicilio.dart';

abstract class DomicilioLDBDao {
  // TODO: Definir métodos para obtener cierto domicilio y para actualizarlo

  List<DomicilioOB> getAllDomiciliosLDB();

  bool agregarDomicilioLDB(DomicilioOB domicilioOB);

  bool eliminarDomicilioLDB(int idDomicilioOB);
}
