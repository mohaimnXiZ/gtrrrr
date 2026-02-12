import 'package:dio/dio.dart';
import '../../../main.dart';
import 'api_functions.dart';
import 'api_logger.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = preferences!.getString('token');

    if (!isPublicEndpoint(options.path) && token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': options.data is FormData ? 'multipart/form-data' : 'application/json',
    });

    ApiLogger.request(options.method, options.uri.toString());
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    ApiLogger.response(response.statusCode ?? 0, response.requestOptions.uri.toString());
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    ApiLogger.error(err.response?.statusCode, err.requestOptions.uri.toString(), err.message ?? 'Unknown error');
    super.onError(err, handler);
  }
}
