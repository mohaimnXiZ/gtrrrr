import 'api_endpoints.dart';

bool isPublicEndpoint(String path) {
  const publicPaths = [Endpoints.login, Endpoints.signup, Endpoints.courses];

  return publicPaths.any((p) => path.startsWith(p));
}
