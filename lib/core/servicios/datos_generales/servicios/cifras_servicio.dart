import 'package:pos/core/dao/datos_generales/dao/cifras_dao.dart';
import 'package:pos/domain/entities/cifras.dart';

class CifrasServicio {
  final CifrasLDBDao cifrasRepositorio;

  CifrasServicio(this.cifrasRepositorio);

  List<CifrasOB> getAllCifrasLDB() {
    return cifrasRepositorio.getAllCifrasLDB();
  }

  bool agregarCifrasLDB(CifrasOB cifrasOB) {
    List<CifrasOB> cifrasExistentes = cifrasRepositorio.getAllCifrasLDB();

    if (cifrasExistentes.isNotEmpty) {
      return false;
    }
    return cifrasRepositorio.agregarCifrasLDB(cifrasOB);
  }

  bool eliminarCifrasLDB(int cifrasId) {
    return cifrasRepositorio.eliminarCifrasLDB(cifrasId);
  }

  bool updateCifras(CifrasOB cifrasOB) {
    return cifrasRepositorio.updateCifrasLDB(cifrasOB);
  }
}
