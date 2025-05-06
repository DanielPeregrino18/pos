import 'package:pos/core/dao/datos_generales/dao/cliente_dao.dart';
import 'package:pos/domain/entities/cliente.dart';

class ClienteServicio {
  final ClienteLDBDao clienteRepositorio;

  ClienteServicio(this.clienteRepositorio);

  List<ClienteOB> getAllClientesLDB() {
    return clienteRepositorio.getAllClientesLDB();
  }

  bool agregarClienteLDB(ClienteOB clienteOB) {
    if (clienteRepositorio
        .existeClientePorIdLDB(clienteOB.id_Cliente)
        .isNotEmpty) {
      return false;
    }
    return clienteRepositorio.agregarClienteLDB(clienteOB);
  }

  bool eliminarClienteLDB(int idClienteOB) {
    return clienteRepositorio.eliminarClienteLDB(idClienteOB);
  }

  ClienteOB? getClienteByIdLDB(int idClienteOB) {
    ClienteOB? clienteOB = clienteRepositorio.getClienteByIdLDB(idClienteOB);
    if (clienteOB != null) {
      return clienteOB;
    } else {
      throw Exception("Cliente no encontrado");
    }
  }

  bool updateCliente(ClienteOB clienteOB) {
    List<ClienteOB> clientePorId = clienteRepositorio.existeClientePorIdLDB(
      clienteOB.id_Cliente,
    );

    if (clientePorId.isNotEmpty) {
      if (clientePorId[0].id_Cliente != clienteOB.id_Cliente) {
        return false;
      }
    }

    return clienteRepositorio.updateClienteLDB(clienteOB);
  }
}
