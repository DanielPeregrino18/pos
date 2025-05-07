// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendedor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vendedor _$VendedorFromJson(Map<String, dynamic> json) => Vendedor(
      (json['id_Usuario'] as num).toInt(),
      json['nombre'] as String,
    );

Map<String, dynamic> _$VendedorToJson(Vendedor instance) => <String, dynamic>{
      'id_Usuario': instance.id_Usuario,
      'nombre': instance.nombre,
    };
