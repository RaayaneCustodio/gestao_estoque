import 'package:gestao_estoque/models/user.dart';
import 'package:gestao_estoque/services/pocketbase_client.dart';
import 'package:pocketbase/pocketbase.dart';

class AuthRepository {
  AuthRepository({PocketBase? pb}) : _pb = pb ?? pocketBaseClient;

  final PocketBase _pb;

  bool get isAuthenticated => _pb.authStore.isValid;

  AppUser? get currentUser {
    final record = _pb.authStore.record;
    if (record == null || !_pb.authStore.isValid) {
      return null;
    }
    return AppUser.fromRecord(record);
  }

  Future<AppUser> login(String email, String password) async {
    final auth = await _pb
        .collection('users')
        .authWithPassword(email.trim(), password);
    return AppUser.fromRecord(auth.record);
  }

  void logout() {
    _pb.authStore.clear();
  }
}
