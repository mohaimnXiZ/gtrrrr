enum ApiErrorType { network, timeout, unauthorized, forbidden, notFound, validation, server, unknown }

class ApiError {
  final ApiErrorType type;
  final String message;
  final int? statusCode;
  final dynamic raw;

  const ApiError({required this.type, required this.message, this.statusCode, this.raw});

  @override
  String toString() => 'ApiError(type: $type, status: $statusCode, message: $message)';
}
