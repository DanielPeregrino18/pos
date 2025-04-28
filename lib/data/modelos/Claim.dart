import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'UserModel.dart';

part 'Claim.g.dart';

//La clase abstracta contiene nuestra declaracion de AP que queremos llamar.
@RestApi(baseUrl: 'https://appimobile.adssystems.com.mx/api/')
abstract class ClaimApi{

  factory ClaimApi(Dio dio, {String? baseUrl}) = _ClaimApi;

  @POST('/login/AppLogin')
  Future<Claim> login(@Body() UserModel usermodel);
}


//modelo de datos obtenidos por la api de reporte de ventas
@JsonSerializable()
class Claim {

  Claim({this.Success, this.Master, this.CompanyName, this.Email, this.LoginDate, this.IdSaas, this.IdCompany, this.IdSubscription});

  //La función privada FromJson es generada po build_runner.
  factory Claim.fromJson(Map<String,dynamic> json) => _$ClaimFromJson(json);
  bool? Success;
  bool? Master;
  String? CompanyName;

  String? Email;

  String? LoginDate;

  String?  IdSaas;

  int? IdCompany;

  int? IdSubscription;

  //La función privada toJson es generada po build_runner.
  Map<String, dynamic> toJson() => _$ClaimToJson(this);
}