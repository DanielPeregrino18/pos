import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/servicios/datos_generales/clientes_servicio.dart';
import 'package:pos/domain/entities/cliente.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';

// LDB = Local Database
class ClientesViewModel extends ChangeNotifier {
  // Mostrar clientes
  List<ClienteOB> clientes = [];

  List<ClienteOB> clientesFiltrados = [];

  final ClienteServicio _clienteServicio;

  ClienteOB? clienteActualizado;

  ClientesViewModel(this._clienteServicio);

  void getAllClientesLDB() {
    clientes = _clienteServicio.getAllClientesLDB();
    clientesFiltrados = clientes;
  }

  void filtrarClientes(String value) {
    if (value.isEmpty) {
      clientesFiltrados = clientes;
    } else {
      clientesFiltrados =
          clientes
              .where(
                (cliente) =>
                    cliente.RFC.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  bool eliminarCliente(int indexClienteFiltrado) {
    int idClienteOB = clientesFiltrados[indexClienteFiltrado].id;

    clientesFiltrados.removeWhere(
      (clienteFiltrado) => clienteFiltrado.id == idClienteOB,
    );

    clientes.removeWhere((cliente) => cliente.id == idClienteOB);

    return _clienteServicio.eliminarClienteLDB(idClienteOB);
  }

  bool agregarCliente(ClienteOB clienteOB) {
    return _clienteServicio.agregarClienteLDB(clienteOB);
  }

  void getClienteActualizado(int idClienteOB) {
    clienteActualizado = _clienteServicio.getClienteByIdLDB(idClienteOB);
  }

  bool actualizarCliente(ClienteOB clienteOB) {
    clienteActualizado = clienteOB;

    return _clienteServicio.updateCliente(clienteOB);
  }
}

// Provider crud clientes

final clientesVMProvider = ChangeNotifierProvider<ClientesViewModel>(
  (ref) => ClientesViewModel(ref.read(clienteServicioProvider)),
);

// Clientes filtrados provider

final clientesFiltradosProv = StateProvider<List<ClienteOB>>((ref) {
  final inputSearch = ref.watch(inputSearchProvider);
  final clientes = ref.watch(clienteServicioProvider).getAllClientesLDB();
  return clientes
      .where(
        (clienteOB) =>
            clienteOB.RFC.toLowerCase().contains(inputSearch.toLowerCase()),
      )
      .toList();
});
