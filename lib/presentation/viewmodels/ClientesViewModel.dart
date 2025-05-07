import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/data/modelos/api_service_response_models/api_clientes_response.dart';
import 'package:pos/data/modelos/api_service_response_models/models.dart';
import 'package:pos/data/repositorios/repositorio_clientes.dart';

class ClientesNotifier extends StateNotifier<List<ApiClientesResponse>> {
  ClientesNotifier() : super([]);

  final RepositorioClientes _repositorioClientes = RepositorioClientes();

  Future<void> fetchClients(int idSucursal, int idCaja, String conn) async {
    try {
      // final List<ApiClientesResponse> clientes = await _repositorioClientes
      //     .getData(idSucursal, idCaja, conn);

      final List<Almacen> almacenes = [
        Almacen(5, "REFRI-GOMEZ", "REFRI-GOMEZ"),
      ];

      final List<dynamic> prioridades = [];

      final List<Cliente> clientess = [
        Cliente(1, "CLIENTE DE CONTADO", "XAXX010101000", 0.0, 0, 0, "G03"),
        Cliente(
          73087,
          "NORMA PATRICIA BLANCO CARDENAS",
          "BACN7002206Z3",
          0.0,
          0,
          0,
          "G01",
        ),
      ];

      final List<Moneda> moneda = [
        Moneda(0, "Nacional", "MXN"),
        Moneda(1, "DOLARES", "USD"),
      ];

      final List<ListaPrecios> lista_precios = [
        ListaPrecios(1, "PR. AL PUBLICO"),
      ];

      final List<Domicilio> domicilios = [
        Domicilio(1, "", "", "CD. JUAREZ", "32340", 0, "CHIHUAHUA"),
        Domicilio(
          2,
          "AVE. DE LA RAZA",
          "COL.CONDESA",
          "CD.JUAREZ,CHIH",
          "32320",
          0,
          "CHIHUAHUA",
        ),
      ];

      final List<dynamic> tipo_entrega = [];

      final List<Vendedor> vendedores = [
        Vendedor(22, "FELIPE_GUILLEN"),
        Vendedor(70, "EDUARDO_POSADAS"),
      ];

      final double paridad = 19.2;
      final int idMovC = 570709;
      final int idMovP = 450424;

      final ApiClientesResponse datos = ApiClientesResponse(
        almacenes: almacenes,
        prioridades: prioridades,
        clientes: clientess,
        moneda: moneda,
        lista_precios: lista_precios,
        tipo_entrega: tipo_entrega,
        domicilios: domicilios,
        vendedores: vendedores,
        paridad: paridad,
        idMovC: idMovC,
        idMovP: idMovP,
      );

      final List<ApiClientesResponse> datosSimulados = [datos];

      state = datosSimulados;

      // state = clientes;
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
