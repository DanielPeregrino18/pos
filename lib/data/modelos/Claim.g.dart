// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Claim _$ClaimFromJson(Map<String, dynamic> json) => Claim(
      Success: json['Success'] as bool?,
      Master: json['Master'] as bool?,
      CompanyName: json['CompanyName'] as String?,
      Email: json['Email'] as String?,
      LoginDate: json['LoginDate'] as String?,
      IdSaas: json['IdSaas'] as String?,
      IdCompany: (json['IdCompany'] as num?)?.toInt(),
      IdSubscription: (json['IdSubscription'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClaimToJson(Claim instance) => <String, dynamic>{
      'Success': instance.Success,
      'Master': instance.Master,
      'CompanyName': instance.CompanyName,
      'Email': instance.Email,
      'LoginDate': instance.LoginDate,
      'IdSaas': instance.IdSaas,
      'IdCompany': instance.IdCompany,
      'IdSubscription': instance.IdSubscription,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _ClaimApi implements ClaimApi {
  _ClaimApi(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'https://appimobile.adssystems.com.mx/api/';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<Claim> login(UserModel usermodel) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(usermodel.toJson());
    final _options = _setStreamType<Claim>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/login/AppLogin',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late Claim _value;
    try {
      _value = Claim.fromJson(_result.data!);
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
