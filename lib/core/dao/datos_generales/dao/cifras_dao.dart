import 'package:pos/domain/entities/cifras.dart';

// LDB = Local Database

abstract class CifrasLDBDao {
  List<CifrasOB> getAllCifrasLDB();

  bool agregarCifrasLDB(CifrasOB cifrasOB);

  bool eliminarCifrasLDB(int cifrasId);

  bool updateCifrasLDB(CifrasOB cifrasOB);
}
