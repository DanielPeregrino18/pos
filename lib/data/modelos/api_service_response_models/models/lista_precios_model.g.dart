// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista_precios_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListaPrecios _$ListaPreciosFromJson(Map<String, dynamic> json) => ListaPrecios(
      (json['ID_LISTA'] as num).toInt(),
      json['NOMBRE'] as String,
    );

Map<String, dynamic> _$ListaPreciosToJson(ListaPrecios instance) =>
    <String, dynamic>{
      'ID_LISTA': instance.ID_LISTA,
      'NOMBRE': instance.NOMBRE,
    };
