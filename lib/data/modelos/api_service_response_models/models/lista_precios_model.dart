import 'package:json_annotation/json_annotation.dart';

part 'lista_precios_model.g.dart';

@JsonSerializable()
class ListaPrecios {
  int ID_LISTA;

  String NOMBRE;

  ListaPrecios(this.ID_LISTA, this.NOMBRE);

  factory ListaPrecios.fromJson(Map<String, dynamic> json) =>
      _$ListaPreciosFromJson(json);

  Map<String, dynamic> toJson() => _$ListaPreciosToJson(this);
}
