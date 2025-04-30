import 'package:json_annotation/json_annotation.dart';

part 'almacen_model.g.dart';

@JsonSerializable()
class Almacen {
  int id_almacen;

  String nombre;

  String nombreOrden;

  Almacen(this.id_almacen, this.nombre, this.nombreOrden);

  factory Almacen.fromJson(Map<String, dynamic> json) =>
      _$AlmacenFromJson(json);

  Map<String, dynamic> toJson() => _$AlmacenToJson(this);
}
