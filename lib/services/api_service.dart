import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/user.dart';
import '../models/post.dart';
import '../utils/logger.dart';

class ApiService {
  final http.Client _client;
  final String _baseUrl;

  ApiService({http.Client? client, String? baseUrl})
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? AppConfig.baseUrl;

  /// Mengambil daftar pengguna dari API
  Future<List<User>> getUsers() async {
    try {
      AppLogger.info('GET $_baseUrl/users');
      final response = await _client
          .get(Uri.parse('$_baseUrl/users'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data user. Status: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timeout. Periksa koneksi internet Anda.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Mengambil pengguna berdasarkan ID
  Future<User> getUserById(int id) async {
    try {
      AppLogger.info('GET $_baseUrl/users/$id');
      final response = await _client
          .get(Uri.parse('$_baseUrl/users/$id'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        throw Exception('Gagal memuat data user. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Mengambil daftar post dari API (Latihan 1)
  Future<List<Post>> getPosts() async {
    try {
      AppLogger.info('GET $_baseUrl/posts');
      final response = await _client
          .get(Uri.parse('$_baseUrl/posts'), headers: _buildHeaders())
          .timeout(Duration(seconds: AppConfig.timeoutSeconds));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data post. Status: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timeout.');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json',
      'X-API-Key': AppConfig.apiKey,
    };
  }

  void dispose() {
    _client.close();
  }
}