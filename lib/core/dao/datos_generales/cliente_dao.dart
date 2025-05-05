import 'package:pos/domain/entities/cliente.dart';

// LDB = Local Database

abstract class ClienteLDBDao {
  ClienteOB? getClienteByIdLDB(int idClienteOB);

  List<ClienteOB> getAllClientesLDB();

  bool agregarClienteLDB(ClienteOB clienteOB);

  bool eliminarClienteLDB(int idClienteOB);

  bool updateClienteLDB(ClienteOB clienteOB);

  List<ClienteOB> existeClientePorRFCLDB(String RFC);
}
