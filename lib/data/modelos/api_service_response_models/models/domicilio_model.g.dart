// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domicilio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Domicilio _$DomicilioFromJson(Map<String, dynamic> json) => Domicilio(
      (json['id_Cliente'] as num).toInt(),
      json['domicilio'] as String,
      json['colonia'] as String,
      json['ciudad'] as String,
      json['c_p'] as String,
      (json['plazo'] as num).toInt(),
      json['estado'] as String,
    );

Map<String, dynamic> _$DomicilioToJson(Domicilio instance) => <String, dynamic>{
      'id_Cliente': instance.id_Cliente,
      'domicilio': instance.domicilio,
      'colonia': instance.colonia,
      'ciudad': instance.ciudad,
      'c_p': instance.c_p,
      'plazo': instance.plazo,
      'estado': instance.estado,
    };
