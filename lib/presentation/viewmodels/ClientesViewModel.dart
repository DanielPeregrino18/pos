import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/data/modelos/api_service_response_models/api_clientes_response.dart';
import 'package:pos/data/repositorios/repositorio_clientes.dart';

class ClientesNotifier extends StateNotifier<List<ApiClientesResponse>> {
  ClientesNotifier() : super([]);

  final RepositorioClientes _repositorioClientes = RepositorioClientes();

  Future<void> fetchClients(int idSucursal, int idCaja, String conn) async {
    try {
      final List<ApiClientesResponse> clientes = await _repositorioClientes
          .getData(idSucursal, idCaja, conn);
      state = clientes;
    } catch (e) {
      state = [];
      debugPrint('$e');
    }
  }
}

final clientesProvider =
    StateNotifierProvider<ClientesNotifier, List<ApiClientesResponse>>((ref) {
      return ClientesNotifier();
    });
