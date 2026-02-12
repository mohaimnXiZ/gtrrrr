import 'dart:developer';

class ApiLogger {
  static void request(String method, String url) {
    log('[API →] $method $url');
  }

  static void response(int status, String url) {
    log('[API ✓] $status $url');
  }

  static void error(int? status, String url, String message) {
    log('[API ✗] $status $url → $message');
  }
}
