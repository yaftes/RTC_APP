import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  static Future<void> setToken(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// final storage = FlutterSecureStorage();

// setToken(Map<String, dynamic> token) async{
//   String accessToken = token['access'], refreshToken = token['refresh'];

//   await storage.write(key: 'access_token', value: accessToken);
//   await storage.write(key: 'refresh_token', value: refreshToken);
// }

// Future getAccessToken(){
//   return storage.read(key: 'access_token');
// }

// Future getRefreshToken(){
//   return storage.read(key: 'refresh_token');
// }

// void deleteToken() async {
//   final storage = FlutterSecureStorage();
//   await storage.delete(key: 'access_token');
//   await storage.delete(key: 'refresh_token');
// }