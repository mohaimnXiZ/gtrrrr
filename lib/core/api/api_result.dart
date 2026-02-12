import 'api_error.dart';

class ApiResult<T> {
  final T? data;
  final ApiError? error;

  const ApiResult.success(this.data) : error = null;

  const ApiResult.failure(this.error) : data = null;
}
