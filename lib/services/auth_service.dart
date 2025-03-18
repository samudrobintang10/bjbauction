import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bjbauction/services/api_config.dart';

class AuthService {
  // Login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Prepare request body
      final Map<String, String> requestBody = {
        'email': email,
        'password': password,
      };

      // Make API request
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.loginEndpoint}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      // Parse response
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Successful login - save token
        final accessToken = responseData['data']['access_token'];
        await _saveToken(accessToken);
        
        return {
          'success': true,
          'message': responseData['message'] ?? 'Login berhasil',
          'data': responseData['data'],
        };
      } else {
        // Error response
        return {
          'success': false,
          'message': responseData['message'] ?? 'Login gagal. Silakan coba lagi.',
        };
      }
    } catch (e) {
      // Handle network or other errors
      return {
        'success': false,
        'message': 'Terjadi kesalahan. Periksa koneksi internet Anda.',
        'error': e.toString(),
      };
    }
  }

  // Register method
  Future<Map<String, dynamic>> register(
    String name, 
    String email, 
    String password,
    String confirmPassword,
  ) async {
    try {
      // Prepare request body
      final Map<String, String> requestBody = {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      };

      // Make API request
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.registerEndpoint}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      // Parse response
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Successful registration
        return {
          'success': true,
          'message': responseData['message'] ?? 'Registrasi berhasil',
          'data': responseData['data'],
        };
      } else {
        // Error response
        return {
          'success': false,
          'message': responseData['message'] ?? 'Registrasi gagal. Silakan coba lagi.',
        };
      }
    } catch (e) {
      // Handle network or other errors
      return {
        'success': false,
        'message': 'Terjadi kesalahan. Periksa koneksi internet Anda.',
        'error': e.toString(),
      };
    }
  }

  // Save token to shared preferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  // Get saved token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Remove token (for logout)
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }

  
}