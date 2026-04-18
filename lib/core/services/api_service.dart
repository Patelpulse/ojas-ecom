import 'package:flutter/foundation.dart';

class ApiService {
  // Release builds: VPS Node (ojas_backend) — see ojas_backend PORT (default 5001).
  static const String _prodUrl = 'http://72.61.172.182/api';
  static const String _devUrl = 'http://localhost:5001/api';
  
  static String get baseUrl => kDebugMode ? _devUrl : _prodUrl;
  static String get userBaseUrl => '$baseUrl/user';
}
