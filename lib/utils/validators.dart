class Validators {
  /// Validasi email menggunakan regex sederhana.
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  /// Memeriksa apakah string tidak kosong atau null.
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Memeriksa apakah panjang string berada dalam rentang tertentu.
  static bool hasValidLength(String value, {int min = 1, int max = 100}) {
    final length = value.trim().length;
    return length >= min && length <= max;
  }

  /// Membersihkan input dari karakter berbahaya (Anti-XSS).
  static String sanitize(String input) {
    return input
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .trim();
  }

  /// Validasi teks umum dengan batasan panjang karakter.
  static String? validateText(String? value,
      {String fieldName = 'Field', int minLength = 1, int maxLength = 100}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    if (!hasValidLength(value, min: minLength, max: maxLength)) {
      return '$fieldName harus antara $minLength-$maxLength karakter';
    }
    return null;
  }

  /// Validasi format email.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!isValidEmail(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }

  /// a) Validasi nomor telepon (hanya angka, 10-13 digit)
  static String? validatePhone(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    final regex = RegExp(r'^[0-9]{10,13}$');
    if (!regex.hasMatch(input.trim())) {
      return 'Nomor telepon harus berupa angka 10-13 digit';
    }
    return null;
  }

  /// b) Validasi URL (harus dimulai dengan http:// atau https://)
  static String? validateUrl(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'URL tidak boleh kosong';
    }
    final regex = RegExp(r'^https?:\/\/.+');
    if (!regex.hasMatch(input.trim())) {
      return 'URL harus dimulai dengan http:// atau https://';
    }
    return null;
  }

  /// c) Validasi password (minimal 8 karakter, mengandung huruf kapital, angka, dan simbol)
  static String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (input.length < 8) {
      return 'Password minimal 8 karakter';
    }
    if (!RegExp(r'[A-Z]').hasMatch(input)) {
      return 'Password harus mengandung minimal 1 huruf kapital';
    }
    if (!RegExp(r'[0-9]').hasMatch(input)) {
      return 'Password harus mengandung minimal 1 angka';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(input)) {
      return 'Password harus mengandung minimal 1 simbol';
    }
    return null;
  }
}