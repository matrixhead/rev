import 'package:http/http.dart' as http;
import 'package:revolt_client/src/exceptions/exceptions.dart';

const String baseurl = '0.0.0.0:14702';

typedef RevResponse = http.Response;

class RevHttpClient {
  final String apiUrl;
  final bool debug;
  final http.Client httpClient;
  String? _token;

  RevHttpClient({
    this.apiUrl = baseurl,
    this.debug = false,
    httpClient,
  }) : httpClient = httpClient ?? http.Client();

  set setToken(String? token)=> _token = token;

  Map<String, String> _getBaseHeader() {
    final headers = <String, String>{};
    if (_token != null) {
      headers["X-Session-Token"] = _token!;
    }
    return headers;
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
    if (res.statusCode >= 200 && res.statusCode <300 ) {
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
    if (res.statusCode >= 200 && res.statusCode <300 ) {
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
    if (res.statusCode >= 200 && res.statusCode <300 ) {
      return res;
    } else {
      throw NetworkRevError.fromRespone(response: res);
    }
  }
}
