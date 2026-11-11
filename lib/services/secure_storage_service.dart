// lib/services/secure_storage_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service untuk mengelola penyimpanan terenkripsi (Secure Storage).
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const String _keyToken = 'auth_token';

  /// Menyimpan token secara aman.
  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  /// Mengambil token tersimpan.
  Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  /// Menghapus token dari secure storage.
  Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }
}