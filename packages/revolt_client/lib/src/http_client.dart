import 'package:http/http.dart' as http;
import 'package:revolt_client/src/config/config.dart';
import 'package:revolt_client/src/exceptions/exceptions.dart';

typedef RevResponse = http.Response;

class RevHttpClient {
  RevHttpClient({required RevConfig config, http.Client? httpClient})
    : httpClient = httpClient ?? http.Client(),
      apiUrl = '${config.baseUrl}:${config.httpPort}';

  RevHttpClient._internal({required this.apiUrl, required this.httpClient});
  final String apiUrl;
  final http.Client httpClient;

  Map<String, String> _getBaseHeader() {
    final headers = <String, String>{};
    return headers;
  }

  RevHttpClientAuthenticated toAuthenticated(String token) {
    return RevHttpClientAuthenticated(
      token: token,
      httpClient: httpClient,
      apiUrl: apiUrl,
    );
  }

  Future<RevResponse> post({
    required String path,
    String? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final baseHeaders = _getBaseHeader();
    if (headers != null) {
      baseHeaders.addAll(headers);
    }
    final res = await httpClient.post(
      Uri.http(apiUrl, path, queryParameters),
      body: body,
      headers: baseHeaders,
    );
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return res;
    } else {
      throw NetworkRevError.fromRespone(response: res);
    }
  }

  Future<RevResponse> put({
    required String path,
    String? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final baseHeaders = _getBaseHeader();
    if (headers != null) {
      baseHeaders.addAll(headers);
    }
    final res = await httpClient.put(
      Uri.http(apiUrl, path, queryParameters),
      body: body,
      headers: baseHeaders,
    );
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return res;
    } else {
      throw NetworkRevError.fromRespone(response: res);
    }
  }

  Future<RevResponse> get({
    required String path,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final baseHeaders = _getBaseHeader();
    if (headers != null) {
      baseHeaders.addAll(headers);
    }
    final res = await httpClient.get(
      Uri.http(apiUrl, path, queryParameters),
      headers: baseHeaders,
    );
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return res;
    } else {
      throw NetworkRevError.fromRespone(response: res);
    }
  }
}

class RevHttpClientAuthenticated extends RevHttpClient {
  RevHttpClientAuthenticated({
    required String token,
    required super.httpClient,
    required super.apiUrl,
  }) : _token = token,
       super._internal();

  final String _token;

  @override
  Map<String, String> _getBaseHeader() {
    final headers = super._getBaseHeader();
    headers['X-Session-Token'] = _token;
    return headers;
  }
}
