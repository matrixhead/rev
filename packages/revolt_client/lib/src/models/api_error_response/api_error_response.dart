import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_error_response.freezed.dart';
part 'api_error_response.g.dart';

enum ErrorType {
  @JsonValue("UnverifiedAccount")
  unverifiedAccount,
  @JsonValue("InvalidToken")
  invalidToken,
  @JsonValue("ShortPassword")
  shortPassword,
  unknown,
}

@freezed
class ApiErrorResponse with _$ApiErrorResponse {
  const factory ApiErrorResponse({
    @JsonKey(name: "type",unknownEnumValue: ErrorType.unknown) required ErrorType errortype,
  }) = _ApiErrorResponse;
  factory ApiErrorResponse.fromJson(Map<String, Object?> json) =>
      _$ApiErrorResponseFromJson(json);
}
