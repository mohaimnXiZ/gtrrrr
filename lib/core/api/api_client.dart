import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'api_error.dart';
import 'api_result.dart';
import 'api_error_mapper.dart';
import 'api_interceptor.dart';

class ApiClient {
  late final Dio _dio;

  final String baseUrl = Endpoints.baseUrl;

  ApiClient() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    _dio.interceptors.add(ApiInterceptor());
  }

  Future<ApiResult<Response>> get(String endpoint, {Map<String, dynamic>? query}) =>
      _execute(() => _dio.get(endpoint, queryParameters: query));

  Future<ApiResult<Response>> post(String endpoint, {dynamic body}) => _execute(() => _dio.post(endpoint, data: body));

  Future<ApiResult<Response>> put(String endpoint, {dynamic body}) => _execute(() => _dio.put(endpoint, data: body));

  Future<ApiResult<Response>> patch(String endpoint, {dynamic body}) => _execute(() => _dio.patch(endpoint, data: body));

  Future<ApiResult<Response>> delete(String endpoint) => _execute(() => _dio.delete(endpoint));

  Future<ApiResult<Response>> _execute(Future<Response> Function() request) async {
    try {
      final response = await request();
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(ApiErrorMapper.fromDio(e));
    } catch (e) {
      return ApiResult.failure(ApiError(type: ApiErrorType.unknown, message: e.toString()));
    }
  }
}
