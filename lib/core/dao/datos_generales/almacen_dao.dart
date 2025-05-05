import 'package:pos/domain/entities/almacen.dart';

// LDB = Local Database

abstract class AlmacenLDBDao {
  AlmacenOB? getAlmacenByIdLDB(int idAlmacenOB);

  List<AlmacenOB> getAllAlmacenesLDB();

  bool agregarAlmacenLDB(AlmacenOB almacenOB);

  bool eliminarAlmacenLDB(int idAlmacenOB);

  bool updateAlmacenLDB(AlmacenOB almacenOB);

  List<AlmacenOB> existeAlmacenPorIdLDB(int idAlmacenOB);
}
