import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/data/modelos/Claim.dart';
import 'package:pos/presentation/viewmodels/LoginViewModel.dart';

import '../../widgets/drawer_pos.dart';

class Ajustes extends ConsumerStatefulWidget {
  const Ajustes({Key? key}) : super(key: key);

  @override
  ConsumerState<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends ConsumerState<Ajustes> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    Color pickerColor = Color(0xff443a49);
    Color currentColor = Color(0xff003a49);


    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

    final Claim claim = ref.read(loginStateProvider).claim!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ajustes",
          style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.primary),
        backgroundColor: currentColor,
      ),
      drawer: DrawerPos(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
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
                        print(theme.primary);
                      });
                    }, child: Text("Aceptar"))
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
