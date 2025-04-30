import 'package:json_annotation/json_annotation.dart';

part 'vendedor_model.g.dart';

@JsonSerializable()
class Vendedor {
  int id_Usuario;

  String nombre;

  Vendedor(this.id_Usuario, this.nombre);

  factory Vendedor.fromJson(Map<String, dynamic> json) =>
      _$VendedorFromJson(json);

  Map<String, dynamic> toJson() => _$VendedorToJson(this);
}
