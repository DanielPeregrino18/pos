// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cliente _$ClienteFromJson(Map<String, dynamic> json) => Cliente(
      (json['id_Cliente'] as num).toInt(),
      json['razon_Social'] as String,
      json['RFC'] as String,
      (json['descuento'] as num).toDouble(),
      (json['NO_Plazo'] as num).toInt(),
      (json['id_lista'] as num).toInt(),
      json['cfdi'] as String,
    );

Map<String, dynamic> _$ClienteToJson(Cliente instance) => <String, dynamic>{
      'id_Cliente': instance.id_Cliente,
      'razon_Social': instance.razon_Social,
      'RFC': instance.RFC,
      'descuento': instance.descuento,
      'NO_Plazo': instance.NO_Plazo,
      'id_lista': instance.id_lista,
      'cfdi': instance.cfdi,
    };
