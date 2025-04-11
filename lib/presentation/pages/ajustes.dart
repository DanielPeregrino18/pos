import 'package:flutter/material.dart';

import '../widgets/drawer_pos.dart';

class Ajustes extends StatefulWidget {
  const Ajustes({Key? key}) : super(key: key);

  @override
  _AjustesState createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajustes"),),
      drawer: DrawerPos(),
      body: Text("Ajustes en construcción"),
    );
  }
}
