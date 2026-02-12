import 'package:dio/dio.dart';
import 'api_error.dart';

class ApiErrorMapper {
  static ApiError fromDio(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const ApiError(type: ApiErrorType.timeout, message: 'Connection timeout');
    }

    if (e.type == DioExceptionType.connectionError) {
      return const ApiError(type: ApiErrorType.network, message: 'No internet connection');
    }

    switch (status) {
      case 400:
      case 422:
        return ApiError(type: ApiErrorType.validation, message: _extractMessage(data) ?? 'Invalid request', statusCode: status, raw: data);

      case 401:
        return ApiError(type: ApiErrorType.unauthorized, message: 'Unauthorized', statusCode: status, raw: data);

      case 403:
        return ApiError(type: ApiErrorType.forbidden, message: 'Forbidden', statusCode: status, raw: data);

      case 404:
        return ApiError(type: ApiErrorType.notFound, message: 'Not found', statusCode: status);

      case 500:
      case 502:
      case 503:
        return ApiError(type: ApiErrorType.server, message: 'Server error', statusCode: status);

      default:
        return ApiError(type: ApiErrorType.unknown, message: _extractMessage(data) ?? 'Unexpected error', statusCode: status, raw: data);
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map) {
      if (data['message'] != null) {
        return data['message'].toString();
      }
      if (data['error'] != null) {
        return data['error'].toString();
      }
    }

    if (data is String && data.trim().isNotEmpty) {
      return data;
    }

    return null;
  }
}
