import 'package:pos/core/dao/datos_generales/dao/moneda_dao.dart';
import 'package:pos/domain/entities/entities.dart';

class MonedaServicio {
  final MonedaLDBDao monedaRepositorio;

  MonedaServicio(this.monedaRepositorio);

  List<MonedaOB> getAllMonedasLDB() {
    return monedaRepositorio.getAllMonedasLDB();
  }

  bool agregarMonedaLDB(MonedaOB monedaOB) {
    if (monedaRepositorio.existeMonedaPorIdLDB(monedaOB.IdMoneda).isNotEmpty) {
      return false;
    }
    return monedaRepositorio.agregarMonedaLDB(monedaOB);
  }

  bool eliminarMonedaLDB(int idMonedaOB) {
    return monedaRepositorio.eliminarMonedaLDB(idMonedaOB);
  }

  MonedaOB? getMonedaByIdLDB(int idMonedaOB) {
    MonedaOB? monedaOB = monedaRepositorio.getMonedaByIdLDB(idMonedaOB);
    if (monedaOB != null) {
      return monedaOB;
    } else {
      throw Exception("Moneda no encontrada");
    }
  }

  bool updateMoneda(MonedaOB monedaOB) {
    List<MonedaOB> monedaPorId = monedaRepositorio.existeMonedaPorIdLDB(
      monedaOB.IdMoneda,
    );

    if (monedaPorId.isNotEmpty) {
      if (monedaPorId[0].IdMoneda != monedaOB.IdMoneda) {
        return false;
      }
    }

    return monedaRepositorio.updateMonedaLDB(monedaOB);
  }
}
