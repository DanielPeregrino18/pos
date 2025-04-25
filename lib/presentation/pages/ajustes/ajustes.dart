import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/data/modelos/Claim.dart';
import 'package:pos/presentation/viewmodels/LoginViewModel.dart';

import '../../widgets/drawer_pos.dart';

class Ajustes extends ConsumerStatefulWidget {
  const Ajustes({Key? key}) : super(key: key);

  @override
  ConsumerState<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends ConsumerState<Ajustes> {

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff003a49);


  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;



    final Claim claim = ref.read(loginStateProvider).claim!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ajustes",
          style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.onPrimary),
        backgroundColor: theme.primary,
      ),
      drawer: DrawerPos(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Email: ${claim.Email} ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
            Text("Company name: ${claim.CompanyName}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
            Text("ID Compañia: ${claim.IdCompany}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
            Text("ID Saas: ${claim.IdSaas}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
            Text("ID Suscripción: ${claim.IdSubscription}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
            Text("Cuenta Master: ${claim.Master!?"Si": "No"}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
            ElevatedButton(onPressed: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text("Selecciona el color"),
                  content: SingleChildScrollView(
                    child: ColorPicker(pickerColor: pickerColor, onColorChanged: changeColor),
                  ),
                  actions: [
                    TextButton(onPressed: () {
                      setState(() {
                        currentColor = pickerColor;
                        ref.read(colorSchemeProvider.notifier).state = ColorScheme.fromSeed(seedColor: pickerColor);
                        context.pop();
                      });
                    }, child: Text("Aceptar", style: TextStyle(color: theme.primary),),)
                  ],
                );
              },);
            }, child: Text("Color de app"))

          ],
        ),
      ),
    );
  }
}
