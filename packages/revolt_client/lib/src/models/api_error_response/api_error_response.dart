import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_error_response.g.dart';

@JsonEnum()
enum ErrorType {
  @JsonValue("UnverifiedAccount")
  unverifiedAccount,
  @JsonValue("InvalidToken")
  invalidToken,
  @JsonValue("ShortPassword")
  shortPassword,
  @JsonValue("AlreadyOnboarded")
  alreadyOnboarded,
  @JsonValue("MissingPermission")
  missingPermission,
  unknown,
}

@JsonSerializable()
class ApiErrorResponse {
  @JsonKey(name: "type", unknownEnumValue: ErrorType.unknown)
  final ErrorType errortype;

  const ApiErrorResponse({
    required this.errortype,
  });

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorResponseToJson(this);
}
