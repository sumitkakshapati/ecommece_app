import 'dart:convert';

import 'package:ecommerce_app/features/auth/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _tokenKey = "userToken";
  static const String _userKey = "user";

  static Future<void> setuserToken(String token) async {
    final _sharedPref = await SharedPreferences.getInstance();
    await _sharedPref.setString(_tokenKey, token);
  }

  static Future<String?> get userToken async {
    final _sharedPref = await SharedPreferences.getInstance();
    return await _sharedPref.getString(_tokenKey);
  }

  static Future<void> deleteUserToken() async {
    final _sharedPref = await SharedPreferences.getInstance();
    await _sharedPref.remove(_tokenKey);
  }

  static Future<void> setUser(User user) async {
    final _sharedPref = await SharedPreferences.getInstance();
    final Map<String, dynamic> _userMap = user.toJson();
    final String _encodedData = json.encode(_userMap);
    await _sharedPref.setString(_userKey, _encodedData);
  }

  static Future<User?> get user async {
    final _sharedPref = await SharedPreferences.getInstance();
    final _encodedData = await _sharedPref.getString(_userKey);
    if (_encodedData != null) {
      final _decodedData = json.decode(_encodedData);
      final _mapData = Map<String, dynamic>.from(_decodedData);
      return User.fromJson(_mapData);
    } else {
      return null;
    }
  }

  static Future<void> deleteUser() async {
    final _sharedPref = await SharedPreferences.getInstance();
    await _sharedPref.remove(_userKey);
  }
}
