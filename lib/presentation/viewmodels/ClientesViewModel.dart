import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/data/modelos/api_service_response_models/api_clientes_response.dart';
import 'package:pos/data/repositorios/repositorio_clientes.dart';

class ClientesNotifier extends StateNotifier<List<ApiClientesResponse>> {
  ClientesNotifier() : super([]);

  final RepositorioClientes _repositorioClientes = RepositorioClientes();

  Future<void> fetchClients(int idSucursal, int idCaja, String conn) async {
    // print('hola1');
    // final List<ApiClientesResponse> datos = await _repositorioClientes
    //     .getData(idSucursal, idCaja, conn);
    // print('hola2');
    // state = datos;
    // print('hola3');

    try {
      print('start try');
      final List<ApiClientesResponse> clientes = await _repositorioClientes
          .getData(idSucursal, idCaja, conn);
      state = clientes;
      print('end try');
    } catch (e) {
      state = [];
      print(e);
    }
  }
}

final clientesProvider =
    StateNotifierProvider<ClientesNotifier, List<ApiClientesResponse>>((ref) {
      return ClientesNotifier();
    });
