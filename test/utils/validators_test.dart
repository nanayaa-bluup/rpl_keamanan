import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/utils/validators.dart'; // Sesuaikan nama package aplikasi kamu

void main() {
  group('Validators Unit Tests', () {
        group('isValidEmail()', () {
      test('mengembalikan true untuk format email yang valid', () {
        expect(Validators.isValidEmail('user@example.com'), isTrue);
        expect(Validators.isValidEmail('john.doe@domain.co.id'), isTrue);
        expect(Validators.isValidEmail('admin+test@sub.domain.org'), isTrue);
      });

      test('mengembalikan false untuk format email yang tidak valid', () {
        expect(Validators.isValidEmail('invalid-email'), isFalse);
        expect(Validators.isValidEmail('user@'), isFalse);
        expect(Validators.isValidEmail('@domain.com'), isFalse);
        expect(Validators.isValidEmail('user@domain'), isFalse);
        expect(Validators.isValidEmail(''), isFalse);
      });
    });

    group('sanitize()', () {
      test('membersihkan tag HTML dan karakter berbahaya', () {
        const inputBermasalah = '<script>alert("hack")</script>';
        final hasilSanitasi = Validators.sanitize(inputBermasalah);

        expect(hasilSanitasi, isNot(contains('<script>')));
        expect(hasilSanitasi, isNot(contains('</script>')));
      });

      test('mengubah karakter khusus menjadi HTML entities', () {
        const inputKarakterKhusus = 'Hello "World" & \'Test\'';
        final hasilSanitasi = Validators.sanitize(inputKarakterKhusus);

        expect(hasilSanitasi, contains('&quot;'));
        expect(hasilSanitasi, contains('&#x27;'));
      });

      test('menghapus spasi di awal dan akhir string', () {
        expect(Validators.sanitize('   teks bersih   '), equals('teks bersih'));
      });
    });

    group('validateText()', () {
      test('mengembalikan null jika input valid sesuai batas panjang', () {
        final result = Validators.validateText('Budi', fieldName: 'Nama', minLength: 2, maxLength: 10);
        expect(result, isNull);
      });

      test('mengembalikan pesan error jika input kosong atau null', () {
        expect(Validators.validateText(''), equals('Field tidak boleh kosong'));
        expect(Validators.validateText(null, fieldName: 'Username'), equals('Username tidak boleh kosong'));
      });

      test('mengembalikan pesan error jika input kurang dari minLength', () {
        final result = Validators.validateText('A', fieldName: 'Kode', minLength: 3, maxLength: 10);
        expect(result, equals('Kode harus antara 3-10 karakter'));
      });

      test('mengembalikan pesan error jika input melebihi maxLength', () {
        final result = Validators.validateText('TeksIniTerlaluPanjang', fieldName: 'Kode', minLength: 1, maxLength: 5);
        expect(result, equals('Kode harus antara 1-5 karakter'));
      });
    });

    group('validatePhone()', () {
      test('mengembalikan null untuk nomor telepon valid (10-13 digit angka)', () {
        expect(Validators.validatePhone('081234567890'), isNull);
      });

      test('mengembalikan error untuk nomor kurang dari 10 atau lebih dari 13 digit', () {
        expect(Validators.validatePhone('12345'), isNotNull);
        expect(Validators.validatePhone('123456789012345'), isNotNull);
      });

      test('mengembalikan error jika mengandung karakter selain angka', () {
        expect(Validators.validatePhone('08123456789a'), isNotNull);
      });
    });

    group('validateUrl()', () {
      test('mengembalikan null untuk URL yang diawali http:// atau https://', () {
        expect(Validators.validateUrl('https://google.com'), isNull);
        expect(Validators.validateUrl('http://localhost:8080'), isNull);
      });

      test('mengembalikan error untuk URL tanpa protokol', () {
        expect(Validators.validateUrl('google.com'), isNotNull);
        expect(Validators.validateUrl('ftp://example.com'), isNotNull);
      });
    });

    group('validatePassword()', () {
      test('mengembalikan null untuk password yang memenuhi seluruh kriteria', () {
        expect(Validators.validatePassword('P@ssword1'), isNull);
      });

      test('mengembalikan error jika password kurang dari 8 karakter', () {
        expect(Validators.validatePassword('P@ss1'), equals('Password minimal 8 karakter'));
      });

      test('mengembalikan error jika tidak mengandung huruf kapital', () {
        expect(Validators.validatePassword('p@ssword1'), equals('Password harus mengandung minimal 1 huruf kapital'));
      });

      test('mengembalikan error jika tidak mengandung angka', () {
        expect(Validators.validatePassword('P@ssword'), equals('Password harus mengandung minimal 1 angka'));
      });

      test('mengembalikan error jika tidak mengandung simbol', () {
        expect(Validators.validatePassword('Password123'), equals('Password harus mengandung minimal 1 simbol'));
      });
    });
  });
}