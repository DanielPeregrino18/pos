import 'package:dio/dio.dart';
import 'package:pos/core/servicios/api_clientes.dart';
import 'package:pos/data/modelos/api_service_response_models/api_clientes_response.dart';

class RepositorioClientes {
  final ApiClientes _apiClientes;

  RepositorioClientes()
    : _apiClientes = ApiClientes(
        Dio(
          BaseOptions(
            contentType: "application/json",
            // connectTimeout: Duration(seconds: 180),
            // receiveTimeout: Duration(seconds: 180),
          ),
        ),
      );

  Future<List<ApiClientesResponse>> getData(
    int idSucursal,
    int idCaja,
    String conn,
  ) async {
    try {
      final List<ApiClientesResponse> response = await _apiClientes.getData(
        idSucursal,
        idCaja,
        conn,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
