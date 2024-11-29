// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiErrorResponseImpl _$$ApiErrorResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiErrorResponseImpl(
      errortype: $enumDecode(_$ErrorTypeEnumMap, json['type'],
          unknownValue: ErrorType.unknown),
    );

Map<String, dynamic> _$$ApiErrorResponseImplToJson(
        _$ApiErrorResponseImpl instance) =>
    <String, dynamic>{
      'type': _$ErrorTypeEnumMap[instance.errortype]!,
    };

const _$ErrorTypeEnumMap = {
  ErrorType.unverifiedAccount: 'UnverifiedAccount',
  ErrorType.invalidToken: 'InvalidToken',
  ErrorType.shortPassword: 'ShortPassword',
  ErrorType.unknown: 'unknown',
};
