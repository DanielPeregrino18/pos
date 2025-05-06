import 'package:pos/config/DB/ObjectboxConnection.dart';
import 'package:pos/core/dao/datos_generales/dao/cliente_dao.dart';
import 'package:pos/domain/entities/cliente.dart';
import 'package:pos/objectbox.g.dart';

class ClienteDAOObjectboxImpl extends ClienteLDBDao {
  final ObjectboxConnection _connectionDB;

  ClienteDAOObjectboxImpl(this._connectionDB);

  @override
  ClienteOB? getClienteByIdLDB(int idClienteOB) {
    final clientesLDB = _connectionDB.clienteBox;

    return clientesLDB.get(idClienteOB);
  }

  @override
  List<ClienteOB> getAllClientesLDB() {
    final clientesLDB = _connectionDB.clienteBox;

    return clientesLDB.getAll();
  }

  @override
  bool agregarClienteLDB(ClienteOB clienteOB) {
    final clientesLDB = _connectionDB.clienteBox;
    try {
      clientesLDB.put(clienteOB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool eliminarClienteLDB(int idClienteOB) {
    final clientesLDB = _connectionDB.clienteBox;
    try {
      clientesLDB.remove(idClienteOB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool updateClienteLDB(ClienteOB clienteOB) {
    final clientesLDB = _connectionDB.clienteBox;
    try {
      clientesLDB.put(clienteOB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  List<ClienteOB> existeClientePorIdLDB(int clienteId) {
    final clientesLDB = _connectionDB.clienteBox;

    Query<ClienteOB> query =
        clientesLDB.query(ClienteOB_.id_Cliente.equals(clienteId)).build();
    return query.find();
  }
}
