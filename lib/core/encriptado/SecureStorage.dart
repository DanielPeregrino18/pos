

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/modelos/Claim.dart';

class SecureStorage {
  late final FlutterSecureStorage storage;
  final String _keyUser = 'user123';
  SecureStorage(this.storage);

  Future setUser(Claim user) async {
    await storage.write(key: _keyUser, value: jsonEncode(user.toJson()));
  }

  Future<Claim?> getUser() async{
    return Claim.fromJson(json.decode(await storage.read(key: _keyUser)??""));
  }

  Future<bool> isUsuarioLogeado() async {
    String? user = await storage.read(key: _keyUser);
    if(user == null){
      return false;
    }
    return true;
  }
  Future deleteUser() async {
    await storage.delete(key: _keyUser);
  }
}