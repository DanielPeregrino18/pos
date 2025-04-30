import 'package:json_annotation/json_annotation.dart';

part 'moneda_model.g.dart';

@JsonSerializable()
class Moneda {
  int IdMoneda;

  String Nombre;

  String Clave_SAT;

  Moneda(this.IdMoneda, this.Nombre, this.Clave_SAT);

  factory Moneda.fromJson(Map<String, dynamic> json) =>
      _$MonedaFromJson(json);

  Map<String, dynamic> toJson() => _$MonedaToJson(this);
}
