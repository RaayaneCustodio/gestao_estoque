class ApiConfig {
  static const int port = 8090;
  static const String? pcLanIp = '127.0.0.1';

  static String get baseUrl {
    if (pcLanIp != null && pcLanIp!.isNotEmpty) {
      return 'http://$pcLanIp:$port';
    }
    return 'http://127.0.0.1:$port';
  }
}
