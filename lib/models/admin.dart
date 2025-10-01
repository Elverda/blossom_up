import 'package:solo/models/pengguna.dart';


class Admin extends Pengguna {
  String _hakAkses;

  Admin(String userId, String username, String password, this._hakAkses)
      : super(userId, username, password);


  String get hakAkses => _hakAkses;


  set hakAkses(String newHakAkses) {
    _hakAkses = newHakAkses;
  }


  @override
  String tampilkanInfo() {
    return 'ADMIN - ID: $userId, Username: $username, Hak Akses: $_hakAkses';
  }


  String kelolaSistem() {
    return 'Admin $username sedang mengelola sistem.';
  }
}
