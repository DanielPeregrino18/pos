

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/encriptado/SecureStorage.dart';
import 'package:pos/data/modelos/Claim.dart';
import 'package:pos/data/modelos/UserModel.dart';



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

  Future<bool> isUsuarioLogeado() async{
    isLogeado = await secureStorage.isUsuarioLogeado();
    if(isLogeado){
      claim = await secureStorage.getUser();
    }
    return isLogeado;
  }
  Future logout() async{
     claim = null;
     isLogeado = false;
     await secureStorage.deleteUser();
     notifyListeners();
  }
}