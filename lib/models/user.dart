import 'package:solo/models/pengguna.dart';

class User extends Pengguna {
  String _email;

  User(String userId, String username, String password, this._email)
      : super(userId, username, password);

  String get email => _email;

  set email(String newEmail) {
    _email = newEmail;
  }

  @override
  String tampilkanInfo() {
    return 'USER - ID: $userId, Username: $username, Email: $_email';
  }

  String lihatProfil() {
    return 'User $username sedang melihat profilnya.';
  }
}
