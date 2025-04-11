import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.primary)
                  ),
                  prefixIcon: Icon(Icons.email, color: theme.primary,),
                  labelText: "Ingresa tu correo electronico",
                  labelStyle: TextStyle(color: theme.primary)
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El correo no puede estar vacío.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: theme.primary)
                    ),
                    prefixIcon: Icon(Icons.lock, color: theme.primary,),
                    labelText: "Ingresa tu contraseña",
                    labelStyle: TextStyle(color: theme.primary)
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La contraseña no puede estar vacia.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(onPressed: () {
                      context.go("/pos");
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50)
                  ),
                  child: const Text("Iniciar Sesión", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
            ],
          ),
        )
    );
  }
}
