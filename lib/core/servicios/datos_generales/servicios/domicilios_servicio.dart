import 'package:pos/core/dao/datos_generales/dao/domicilio_dao.dart';
import 'package:pos/domain/entities/domicilio.dart';

class DomicilioServicio {
  final DomicilioLDBDao domicilioRepositorio;

  DomicilioServicio(this.domicilioRepositorio);

  // TODO: Implementar métodos para obtener cierto domicilio y para actualizarlo

  List<DomicilioOB> getAllDomiciliosLDB() {
    return domicilioRepositorio.getAllDomiciliosLDB();
  }

  bool agregarDomicilioLDB(DomicilioOB domicilioOB) {
    // Se podría agregar una verificación de existencia aquí
    return domicilioRepositorio.agregarDomicilioLDB(domicilioOB);
  }

  bool eliminarDomicilioLDB(int idDomicilioOB) {
    return domicilioRepositorio.eliminarDomicilioLDB(idDomicilioOB);
  }
}
