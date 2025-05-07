// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moneda_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Moneda _$MonedaFromJson(Map<String, dynamic> json) => Moneda(
      (json['IdMoneda'] as num).toInt(),
      json['Nombre'] as String,
      json['Clave_SAT'] as String,
    );

Map<String, dynamic> _$MonedaToJson(Moneda instance) => <String, dynamic>{
      'IdMoneda': instance.IdMoneda,
      'Nombre': instance.Nombre,
      'Clave_SAT': instance.Clave_SAT,
    };
