// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Venta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Venta _$VentaFromJson(Map<String, dynamic> json) => Venta(
      (json['ID_ZONA'] as num?)?.toInt(),
      (json['ID_SUCURSAL'] as num?)?.toInt(),
      (json['ID_TIPO'] as num?)?.toInt(),
      (json['YEAR'] as num?)?.toInt(),
      (json['MES'] as num?)?.toInt(),
      (json['SEMANA'] as num?)?.toInt(),
      (json['MOVIMIENTOS'] as num?)?.toInt(),
      (json['VALOR'] as num?)?.toDouble(),
      (json['VALOR_USD'] as num?)?.toDouble(),
      json['FILIAL'] as bool?,
      (json['CANTIDAD'] as num?)?.toDouble(),
      json['CANCELADO'] as bool?,
    );

Map<String, dynamic> _$VentaToJson(Venta instance) => <String, dynamic>{
      'ID_ZONA': instance.ID_ZONA,
      'ID_SUCURSAL': instance.ID_SUCURSAL,
      'ID_TIPO': instance.ID_TIPO,
      'YEAR': instance.YEAR,
      'MES': instance.MES,
      'SEMANA': instance.SEMANA,
      'MOVIMIENTOS': instance.MOVIMIENTOS,
      'VALOR': instance.VALOR,
      'VALOR_USD': instance.VALOR_USD,
      'FILIAL': instance.FILIAL,
      'CANTIDAD': instance.CANTIDAD,
      'CANCELADO': instance.CANCELADO,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _VentaApi implements VentaApi {
  _VentaApi(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'http://192.168.1.218:8080/api/';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<List<Venta>> login(
    String idSa,
    int idCom,
    int idSub,
    String fIni,
    String fFin,
    int idSuc,
    int tRep,
    int tA,
    String idArts,
    int idClPr,
    bool cCont,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'idSa': idSa,
      r'idCom': idCom,
      r'idSub': idSub,
      r'fIni': fIni,
      r'fFin': fFin,
      r'idSuc': idSuc,
      r'tRep': tRep,
      r'tA': tA,
      r'idArts': idArts,
      r'idClPr': idClPr,
      r'cCont': cCont,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<Venta>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/reportes/ObtenerLibroGeneral',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<Venta> _value;
    try {
      _value = _result.data!
          .map((dynamic i) => Venta.fromJson(i as Map<String, dynamic>))
          .toList();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
