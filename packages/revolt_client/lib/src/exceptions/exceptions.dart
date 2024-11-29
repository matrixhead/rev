import 'dart:convert';

import 'package:http/http.dart';
import 'package:revolt_client/src/models/api_error_response/api_error_response.dart';

class RevError implements Exception {
  /// Error message
  final String message;

  RevError(this.message);

  @override
  String toString() => 'RevError(message: $message)';
}

class NetworkRevError extends RevError {
  //
  NetworkRevError(String message, this.response) : super(message);

  final Response response;

  factory NetworkRevError.fromRespone({required Response response}) {
    return NetworkRevError(response.body, response);
  }
}

class RevApiError extends RevError {
  RevApiError(String message, {required this.errorResponse}) : super(message);
  final ApiErrorResponse errorResponse;

  factory RevApiError.fromNetworkError(NetworkRevError error) {
    return RevApiError(error.message,
        errorResponse:
            ApiErrorResponse.fromJson(jsonDecode(error.response.body)));
  }
}

class RevAuthError extends RevError{
  RevAuthError(String message) : super(message);
}

class AccountNotVeifiedError extends RevAuthError{
  AccountNotVeifiedError() : super("account not verified");

}

// login Exceptions
class LoginException implements Exception {}

class InvalidCredentialsException implements LoginException {}

//signUp Exception
class SignUpException extends RevAuthError {
  SignUpException(String message):super(message);
}

class VerificationException extends RevAuthError {
  VerificationException(String message):super(message);
}
