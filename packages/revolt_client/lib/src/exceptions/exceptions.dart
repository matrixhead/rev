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
  NetworkRevError(super.message, this.response);

  final Response response;

  factory NetworkRevError.fromRespone({required Response response}) {
    return NetworkRevError(response.body, response);
  }
}

class RevApiError extends RevError {
  final int statuscode;
  RevApiError(super.message, this.statuscode);
  factory RevApiError.fromNetworkError(NetworkRevError error) {
    try{
    return RevApiErrorWithResponse(error.message,
        errorResponse:
            ApiErrorResponse.fromJson(jsonDecode(error.response.body)),statuscode: error.response.statusCode);
    }on Exception {
     return RevApiError(error.response.body,error.response.statusCode);
    }
  }
}

class RevApiErrorWithResponse extends RevApiError {
  RevApiErrorWithResponse(String message,
      {required this.errorResponse, required statuscode})
      : super(message, statuscode);
  final ApiErrorResponse errorResponse;

  factory RevApiErrorWithResponse.fromNetworkError(NetworkRevError error) {
    return RevApiErrorWithResponse(error.message,
        errorResponse:
            ApiErrorResponse.fromJson(jsonDecode(error.response.body)),statuscode: error.response.statusCode);
  }
}

class RevAuthError extends RevError {
  RevAuthError(super.message);
}

class AccountNotVeifiedError extends RevAuthError {
  AccountNotVeifiedError() : super("account not verified");
}

//signUp Exception
class SignUpException extends RevAuthError {
  SignUpException(super.message);
}

class VerificationException extends RevAuthError {
  VerificationException(super.message);
}

class DataError extends RevError {
  final RevApiError apiError;

  factory DataError.fromApiError(RevApiError error) {
    return DataError(apiError: error);
  }

  DataError({required this.apiError}) : super(apiError.message);
}
