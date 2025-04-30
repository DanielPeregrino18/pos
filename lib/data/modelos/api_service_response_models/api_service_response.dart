import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'api_service_response.g.dart';

@JsonSerializable()
class ApiClientesResponse {
  final List<Almacen> almacenes;

  final Map<String, dynamic> prioridades;

  final List<Cliente> clientes;

  final List<Moneda> moneda;

  final List<ListaPrecios> lista_precios;

  final Map<String, dynamic> tipo_entrega;

  final List<Domicilio> domicilios;

  final List<Vendedor> vendedores;

  final double paridad;

  final int idMovC;

  final int idMovP;

  ApiClientesResponse({
    required this.almacenes,
    required this.prioridades,
    required this.clientes,
    required this.moneda,
    required this.lista_precios,
    required this.tipo_entrega,
    required this.domicilios,
    required this.vendedores,
    required this.paridad,
    required this.idMovC,
    required this.idMovP,
  });

  factory ApiClientesResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiClientesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiClientesResponseToJson(this);
}
