import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/pages/login/widgets/form_login.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("¡Bienvenido!", style: TextStyle(fontSize: 50, color: theme.primary, fontWeight: FontWeight.w500 ),),
            FormLogin(),
          ],
        ),
      ),
    );
  }
}
