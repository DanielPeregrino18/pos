import 'package:pos/domain/entities/vendedor.dart';

// LDB = Local Database

abstract class VendedorLDBDao {
  VendedorOB? getVendedorByIdLDB(int idVendedorOB);

  List<VendedorOB> getAllVendedoresLDB();

  bool agregarVendedorLDB(VendedorOB vendedorOB);

  bool eliminarVendedorLDB(int idVendedorLDB);

  bool updateVendedorLDB(VendedorOB vendedorOB);

  List<VendedorOB> existeVendedorPorIdLDB(int idVendedorOB);
}
