

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/modelos/Claim.dart';

class SecureStorage {
  late final FlutterSecureStorage storage;
  final String _keyUser = 'user123'; //Llave del almacenamiento
  SecureStorage(this.storage);

  Future setUser(Claim user) async {
      //Se coloca la llave con la que se almacenará y obtendra la información.
      //Json encode nos permite convertir un mapa (en este caso) o lista en una cadeta de texto JSON.
      //user.Json nos retorna un mapa String Dynamic de la clase Claim (user).
      //Esto se hace ya que  FlutterSecureStorage solo permite almacenar Strings
    await storage.write(key: _keyUser, value: jsonEncode(user.toJson()));
  }

  Future<Claim?> getUser() async{
      // Para obtener el Claim (user) almacenado se obtiene lo que esta almacenado utilizando la llave _keyuser
      //Otenemos el texto JSON y lo decodificamos para obtener un mapa String Dynamic
      //Se lo pasamos al constructor de Claim para construir la instancia del usuario
    return Claim.fromJson(json.decode(await storage.read(key: _keyUser)??""));
  }

  Future<bool> isUsuarioLogeado() async {
    String? user = await storage.read(key: _keyUser); //obtenemos el valor almacenado con la llave _keyUser
    if(user == null){ //Si es null es porque no hay usuarios registrados
      return false;
    }
    return true;
  }
  Future deleteUser() async {
    //Elimina lo que este almacenado sobre la llave _keyUser
    await storage.delete(key: _keyUser);
  }

}