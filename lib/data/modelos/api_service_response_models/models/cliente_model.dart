import 'package:json_annotation/json_annotation.dart';

part 'cliente_model.g.dart';

@JsonSerializable()
class Cliente {
  int id_Cliente;

  String razon_Social;

  String RFC;

  double descuento;

  int NO_Plazo;

  int id_lista;

  String cfdi;

  Cliente(
    this.id_Cliente,
    this.razon_Social,
    this.RFC,
    this.descuento,
    this.NO_Plazo,
    this.id_lista,
    this.cfdi,
  );

  factory Cliente.fromJson(Map<String, dynamic> json) =>
      _$ClienteFromJson(json);

  Map<String, dynamic> toJson() => _$ClienteToJson(this);
}
