import 'package:flutter/foundation.dart';

class ApiService {
  // Static baseUrl for ease of access in controllers
  static const String _prodUrl = 'https://api.samajwaditechforce.com/ojas/api';
  static const String _devUrl  = 'http://localhost:5001/api';
  
  static String get baseUrl => kDebugMode ? _devUrl : _prodUrl;
  static String get userBaseUrl => '$baseUrl/user';
}
