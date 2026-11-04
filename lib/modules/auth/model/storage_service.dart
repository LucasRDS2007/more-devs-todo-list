import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
FlutterSecureStorage  storage = FlutterSecureStorage();

Future<String?> getToken() async {
  return storage.read(key: 'token');
}

Future<void> setToken(String token) async{
  storage.write(key: 'token', value: token);
}

Future<void> deleteToken() async {
  storage.delete(key: 'token');

}

}