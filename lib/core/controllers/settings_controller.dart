import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ojas_user/core/models/app_settings.dart';
import 'package:ojas_user/core/services/api_service.dart';
import 'package:ojas_user/core/services/socket_service.dart';

class SettingsController with ChangeNotifier {
  static final SettingsController instance = SettingsController._internal();
  SettingsController._internal();

  AppSettings _settings = AppSettings.defaultSettings();
  AppSettings get settings => _settings;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    await fetchSettings();
    
    // Listen for real-time settings updates
    SocketService.instance.on('settings', (data) {
      if (data['data'] != null) {
        _settings = AppSettings.fromJson(data['data']);
        notifyListeners();
        debugPrint('Settings auto-updated via socket');
      }
    });
  }

  Future<void> fetchSettings() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(Uri.parse('${ApiService.baseUrl}/home/settings'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null) {
          _settings = AppSettings.fromJson(data['data']);
        }
      }
    } catch (e) {
      debugPrint('Error fetching settings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
