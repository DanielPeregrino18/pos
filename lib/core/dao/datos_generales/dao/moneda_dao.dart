import 'package:pos/domain/entities/moneda.dart';

// LDB = Local Database

abstract class MonedaLDBDao {
  MonedaOB? getMonedaByIdLDB(int idMonedaOB);

  List<MonedaOB> getAllMonedasLDB();

  bool agregarMonedaLDB(MonedaOB monedaOB);

  bool eliminarMonedaLDB(int idMonedaOB);

  bool updateMonedaLDB(MonedaOB monedaOB);

  List<MonedaOB> existeMonedaPorIdLDB(int monedaId);
}
