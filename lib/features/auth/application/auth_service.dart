import 'dart:convert';
import 'dart:html' as html; // Web-only
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ojas_user/core/constants/app_constants.dart';
import '../domain/models/user_model.dart';

class AuthService {
  static const String endpoint = AppConstants.apiBaseUrlUser;

  Future<void> _saveToken(String token) async {
    if (kIsWeb) {
      html.window.localStorage['token'] = token;
    }
  }

  Future<String?> getToken() async {
    if (kIsWeb) {
      return html.window.localStorage['token'];
    }
    return null;
  }

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$endpoint/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['token'] != null) {
          await _saveToken(data['token']);
        }
        return AuthResponse(
          success: true,
          user: data['data'] != null ? UserModel.fromJson(data['data']) : null,
          message: data['message'] ?? 'Login Successful',
          token: data['token'],
        );
      } else {
        return AuthResponse(success: false, message: data['message'] ?? 'Login Failed');
      }
    } catch (e) {
      return AuthResponse(success: false, message: 'Server error: $e');
    }
  }

  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String mobile,
    String role = "user",
    XFile? image,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse('$endpoint/register'));
      
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['gender'] = gender.toLowerCase();
      request.fields['mobile'] = mobile;
      request.fields['role'] = role;

      if (image != null) {
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          request.files.add(http.MultipartFile.fromBytes(
            'photo',
            bytes,
            filename: image.name,
          ));
        } else {
          request.files.add(await http.MultipartFile.fromPath(
            'photo',
            image.path,
          ));
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final data = json.decode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (data['token'] != null) {
          await _saveToken(data['token']);
        }
        return AuthResponse(
          success: true, 
          message: 'Registration Successful',
          token: data['token'],
        );
      } else {
        return AuthResponse(success: false, message: data['message'] ?? 'Registration Failed');
      }
    } catch (e) {
      return AuthResponse(success: false, message: 'Server error: $e');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse('$endpoint/profile'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] != null ? UserModel.fromJson(data['data']) : null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    if (kIsWeb) {
      html.window.localStorage.remove('token');
    }
  }
}

class AuthResponse {
  final bool success;
  final String message;
  final UserModel? user;
  final String? token;

  AuthResponse({required this.success, required this.message, this.user, this.token});
}
