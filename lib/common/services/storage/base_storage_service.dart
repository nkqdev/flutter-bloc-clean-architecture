import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class BaseStorageService {
  final FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
}
