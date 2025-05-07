// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_clientes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiClientesResponse _$ApiClientesResponseFromJson(Map<String, dynamic> json) =>
    ApiClientesResponse(
      almacenes: (json['almacenes'] as List<dynamic>)
          .map((e) => Almacen.fromJson(e as Map<String, dynamic>))
          .toList(),
      prioridades: json['prioridades'] as List<dynamic>,
      clientes: (json['clientes'] as List<dynamic>)
          .map((e) => Cliente.fromJson(e as Map<String, dynamic>))
          .toList(),
      moneda: (json['moneda'] as List<dynamic>)
          .map((e) => Moneda.fromJson(e as Map<String, dynamic>))
          .toList(),
      lista_precios: (json['lista_precios'] as List<dynamic>)
          .map((e) => ListaPrecios.fromJson(e as Map<String, dynamic>))
          .toList(),
      tipo_entrega: json['tipo_entrega'] as List<dynamic>,
      domicilios: (json['domicilios'] as List<dynamic>)
          .map((e) => Domicilio.fromJson(e as Map<String, dynamic>))
          .toList(),
      vendedores: (json['vendedores'] as List<dynamic>)
          .map((e) => Vendedor.fromJson(e as Map<String, dynamic>))
          .toList(),
      paridad: (json['paridad'] as num).toDouble(),
      idMovC: (json['idMovC'] as num).toInt(),
      idMovP: (json['idMovP'] as num).toInt(),
    );

Map<String, dynamic> _$ApiClientesResponseToJson(
        ApiClientesResponse instance) =>
    <String, dynamic>{
      'almacenes': instance.almacenes,
      'prioridades': instance.prioridades,
      'clientes': instance.clientes,
      'moneda': instance.moneda,
      'lista_precios': instance.lista_precios,
      'tipo_entrega': instance.tipo_entrega,
      'domicilios': instance.domicilios,
      'vendedores': instance.vendedores,
      'paridad': instance.paridad,
      'idMovC': instance.idMovC,
      'idMovP': instance.idMovP,
    };
