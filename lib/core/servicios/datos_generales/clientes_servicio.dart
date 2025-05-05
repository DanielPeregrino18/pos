import 'package:pos/core/dao/datos_generales/cliente_dao.dart';
import 'package:pos/domain/entities/cliente.dart';

class ClienteServicio {
  final ClienteLDBDao clienteRepositorio;

  ClienteServicio(this.clienteRepositorio);

  List<ClienteOB> getAllClientesLDB() {
    return clienteRepositorio.getAllClientesLDB();
  }

  bool agregarClienteLDB(ClienteOB clienteOB) {
    if (clienteRepositorio.existeClientePorRFCLDB(clienteOB.RFC).isNotEmpty) {
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
    List<ClienteOB> clientePorRFC = clienteRepositorio.existeClientePorRFCLDB(
      clienteOB.RFC,
    );

    if (clientePorRFC.isNotEmpty) {
      if (clientePorRFC[0].RFC != clienteOB.RFC) {
        return false;
      }
    }

    return clienteRepositorio.updateClienteLDB(clienteOB);
  }
}
