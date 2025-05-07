// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'almacen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Almacen _$AlmacenFromJson(Map<String, dynamic> json) => Almacen(
      (json['id_almacen'] as num).toInt(),
      json['nombre'] as String,
      json['nombreOrden'] as String,
    );

Map<String, dynamic> _$AlmacenToJson(Almacen instance) => <String, dynamic>{
      'id_almacen': instance.id_almacen,
      'nombre': instance.nombre,
      'nombreOrden': instance.nombreOrden,
    };
