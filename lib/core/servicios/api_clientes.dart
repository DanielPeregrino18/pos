import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:pos/data/modelos/api_service_response_models/api_clientes_response.dart';

part 'api_clientes.g.dart';

// http://192.168.1.218:8080/api/
// operaciones/POSopCotPed/OnLoadPedCot?
// idSucursal=5&
// idCaja=2&
// conn=Data Source=192.168.1.199;Initial Catalog=TEST_RRJ;Persist Security Info=True;User ID=Sa;Password=Ads720510*.;

@RestApi(baseUrl: 'http://192.168.1.218:8080/api/')
abstract class ApiClientes {
  factory ApiClientes(Dio dio) = _ApiClientes;

  @GET('operaciones/POSopCotPed/OnLoadPedCot')
  Future<List<ApiClientesResponse>> getData(
    @Query('idSucursal') int idSucursal,
    @Query('idCaja') int idCaja,
    @Query('conn') String conn,
  );
}
