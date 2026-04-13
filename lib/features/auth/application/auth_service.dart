import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ojas_user/core/constants/app_constants.dart';
import '../domain/models/user_model.dart';

class AuthService {
  static const String endpoint = AppConstants.apiBaseUrlUser;

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$endpoint/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return AuthResponse(
          success: true,
          user: data['data'] != null ? UserModel.fromJson(data['data']) : null,
          message: data['message'] ?? 'Login Successful',
        );
      }
 else {
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
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$endpoint/register'),

        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'gender': gender.toLowerCase(),
          'mobile': mobile,
          'role': role,
        }),
      );



      final data = json.decode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return AuthResponse(success: true, message: 'Registration Successful');
      } else {
        return AuthResponse(success: false, message: data['message'] ?? 'Registration Failed');
      }
    } catch (e) {
      return AuthResponse(success: false, message: 'Server error: $e');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final response = await http.get(
        Uri.parse('$endpoint/profile'),
        headers: {'Content-Type': 'application/json'},
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
}

class AuthResponse {
  final bool success;
  final String message;
  final UserModel? user;

  AuthResponse({required this.success, required this.message, this.user});
}
