import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'Venta.g.dart';


//La clase abstracta contiene nuestra declaracion de AP que queremos llamar.
@RestApi(baseUrl: 'http://192.168.1.218:8080/api/')
abstract class VentaApi {
  factory VentaApi(Dio dio, {String? baseUrl}) = _VentaApi;

  //Metodo get con los parametros uri que se van a utilizar (Query), devuelve una lista por que es lo que ergera la api.
  @GET('/reportes/ObtenerLibroGeneral')
  Future<List<Venta>> login(
    @Query('idSa') String idSa,
    @Query('idCom') int idCom,
    @Query('idSub') int idSub,
    @Query('fIni') String fIni,
    @Query('fFin') String fFin,
    @Query('idSuc') int idSuc,
    @Query('tRep') int tRep,
    @Query('tA') int tA,
    @Query('idArts') String idArts,
    @Query('idClPr') int idClPr,
    @Query('cCont') bool cCont,
  );
}

//Modelo que se obtiene por la api de reporte de ventas.
@JsonSerializable()
class Venta {
  Venta(
    this.ID_ZONA,
    this.ID_SUCURSAL,
    this.ID_TIPO,
    this.YEAR,
    this.MES,
    this.SEMANA,
    this.MOVIMIENTOS,
    this.VALOR,
    this.VALOR_USD,
    this.FILIAL,
    this.CANTIDAD,
    this.CANCELADO,
  );
  factory Venta.fromJson(Map<String, dynamic> json) => _$VentaFromJson(json);
  int? ID_ZONA;
  int? ID_SUCURSAL;
  int? ID_TIPO;
  int? YEAR;
  int? MES;
  int? SEMANA;
  int? MOVIMIENTOS;
  double? VALOR;
  double? VALOR_USD;
  bool? FILIAL;
  double? CANTIDAD;
  bool? CANCELADO;

  Map<String, dynamic> toJson() => _$VentaToJson(this);
}
