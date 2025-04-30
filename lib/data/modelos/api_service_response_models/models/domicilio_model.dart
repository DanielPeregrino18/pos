import 'package:json_annotation/json_annotation.dart';

part 'domicilio_model.g.dart';

@JsonSerializable()
class Domicilio {
  int id_Cliente;
  String domicilio;
  String colonia;
  String ciudad;
  String c_p;
  int plazo;
  String estado;

  Domicilio(
    this.id_Cliente,
    this.domicilio,
    this.colonia,
    this.ciudad,
    this.c_p,
    this.plazo,
    this.estado,
  );

  factory Domicilio.fromJson(Map<String, dynamic> json) =>
      _$DomicilioFromJson(json);

  Map<String, dynamic> toJson() => _$DomicilioToJson(this);
}
