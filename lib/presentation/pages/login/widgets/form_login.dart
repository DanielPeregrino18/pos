import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/viewmodels/LoginViewModel.dart';

class FormLogin extends ConsumerStatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  ConsumerState<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends ConsumerState<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
        child: Column(
          spacing: 40.sp,
          children: <Widget>[
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: theme.primary),
                ),
                prefixIcon: Icon(Icons.email, color: theme.primary, size: 50.sp,),
                labelText: "Ingresa tu correo electronico",
                labelStyle: TextStyle(color: theme.primary, fontSize: 40.sp),
              ),
              style: TextStyle(fontSize: 40.sp),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El correo no puede estar vacío.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: theme.primary),
                ),
                prefixIcon: Icon(Icons.lock, color: theme.primary, size: 50.sp,),
                labelText: "Ingresa tu contraseña",
                labelStyle: TextStyle(color: theme.primary, fontSize:  40.sp),
              ),
              style: TextStyle(fontSize: 40.sp),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La contraseña no puede estar vacia.';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final res = await ref.read(loginStateProvider).login(_email.text, _password.text);
                  if (res) {
                    //_email.clear();
                    //_password.clear();
                    context.go("/pos");
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Email o cotraseña incorrectos")),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: const Text(
                "Iniciar Sesión",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
