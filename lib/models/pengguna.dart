import 'package:shared_preferences/shared_preferences.dart';

class Pengguna {
  String _userId;
  String _username;
  String _password;

  Pengguna(this._userId, this._username, this._password);

  String get userId => _userId;
  String get username => _username;

  set username(String newUsername) {
    _username = newUsername;
  }

  bool verifikasiPassword(String inputPassword) {
    return _password == inputPassword;
  }

  String tampilkanInfo() {
    return 'ID Pengguna: $_userId, Username: $_username';
  }

  // Method to save user data to SharedPreferences
  Future<void> saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', _userId);
    await prefs.setString('username', _username);
  }

  // Static method to load user data from SharedPreferences
  static Future<Pengguna?> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final username = prefs.getString('username');

    if (userId != null && username != null) {
      // Password is not saved for security reasons, so we pass an empty string.
      return Pengguna(userId, username, '');
    }
    return null;
  }
}
