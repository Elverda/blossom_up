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

  Future<void> saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', _userId);
    await prefs.setString('username', _username);
  }

  static Future<Pengguna?> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final username = prefs.getString('username');

    if (userId != null && username != null) {
      return Pengguna(userId, username, '');
    }
    return null;
  }
}
