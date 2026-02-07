import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/storage_keys.dart';

/// Service for managing local storage (SharedPreferences & Secure Storage)
class StorageService {
  SharedPreferences? _prefs;
  FlutterSecureStorage? _secureStorage;
  bool _initialized = false;

  /// Initialize storage services
  Future<void> init() async {
    if (_initialized) return;
    
    _prefs = await SharedPreferences.getInstance();
    _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
    _initialized = true;
  }

  /// Check if storage is initialized
  bool get isInitialized => _initialized;

  // ===================== JWT Token (Secure) =====================

  Future<void> saveToken(String token) async {
    await _secureStorage?.write(key: StorageKeys.jwtToken, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage?.read(key: StorageKeys.jwtToken);
  }

  Future<void> deleteToken() async {
    await _secureStorage?.delete(key: StorageKeys.jwtToken);
  }

  // ===================== Wallet Address =====================

  Future<void> saveWalletAddress(String address) async {
    await _prefs?.setString(StorageKeys.walletAddress, address);
  }

  String? getWalletAddress() {
    return _prefs?.getString(StorageKeys.walletAddress);
  }

  // ===================== Username =====================

  Future<void> saveUsername(String username) async {
    await _prefs?.setString(StorageKeys.username, username);
  }

  String? getUsername() {
    return _prefs?.getString(StorageKeys.username);
  }

  // ===================== Login State =====================

  Future<void> setLoggedIn(bool value) async {
    await _prefs?.setBool(StorageKeys.isLoggedIn, value);
  }

  bool isLoggedIn() {
    return _prefs?.getBool(StorageKeys.isLoggedIn) ?? false;
  }

  // ===================== First Time User =====================

  Future<void> setFirstTime(bool value) async {
    await _prefs?.setBool(StorageKeys.isFirstTime, value);
  }

  bool isFirstTime() {
    return _prefs?.getBool(StorageKeys.isFirstTime) ?? true;
  }

  // ===================== FCM Token =====================

  Future<void> saveFcmToken(String token) async {
    await _prefs?.setString(StorageKeys.fcmToken, token);
  }

  String? getFcmToken() {
    return _prefs?.getString(StorageKeys.fcmToken);
  }

  // ===================== Clear All Data =====================

  Future<void> clearAll() async {
    await _prefs?.clear();
    await _secureStorage?.deleteAll();
  }

  Future<void> clearAuthData() async {
    await deleteToken();
    await _prefs?.remove(StorageKeys.walletAddress);
    await _prefs?.remove(StorageKeys.username);
    await setLoggedIn(false);
  }
}
