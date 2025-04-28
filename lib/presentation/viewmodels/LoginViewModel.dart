

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/encriptado/SecureStorage.dart';
import 'package:pos/data/modelos/Claim.dart';
import 'package:pos/data/modelos/UserModel.dart';

//Clase que maneja el login y el estado de la autenticación.
final loginStateProvider = StateProvider<LoginState>((ref) =>
                        LoginState(ref.read(loginApiProvider), ref.read(secureStorageProvider)),);
class LoginState extends ChangeNotifier{
  bool isLogeado = false;
  ClaimApi loginApi;
  Claim? claim;

  SecureStorage secureStorage;

  LoginState(this.loginApi, this.secureStorage) {
    isUsuarioLogeado();
  }

  //Inicia sesion, cambia el estado de logeado a true y almacena el usuario en secureStorage.
  Future<bool> login(String email, String password) async {
    try {
      claim = await loginApi.login(UserModel(email, password));
      isLogeado = true;
      secureStorage.setUser(claim!);
      notifyListeners();
      return true;
    }catch (e){
      return false;
    }
  }

  //Retorna true si el usuario esta logeado, revisa que el usuario este almacenado en secureStorage.
  Future<bool> isUsuarioLogeado() async{
    isLogeado = await secureStorage.isUsuarioLogeado();
    if(isLogeado){
      claim = await secureStorage.getUser();
    }
    return isLogeado;
  }

  //Elimina el usuario almacenado el claim, cambia el estado de logeado a false y elimina el usuario guardado en secureStorage.
  Future logout() async{
     claim = null;
     isLogeado = false;
     await secureStorage.deleteUser();
     notifyListeners();
  }
}