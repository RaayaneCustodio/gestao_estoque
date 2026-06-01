import 'package:gestao_estoque/services/api_config.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final PocketBase pocketBaseClient;
Future<void> setupPocketBase() async {
  final prefs = await SharedPreferences.getInstance();
  final authStore = AsyncAuthStore(
    save: (String data) async {
      await prefs.setString('pb_auth', data);
    },
    clear: () async {
      await prefs.remove('pb_auth');
    },
    initial: prefs.getString('pb_auth'),
  );
  pocketBaseClient = PocketBase(ApiConfig.baseUrl, authStore: authStore);
}
