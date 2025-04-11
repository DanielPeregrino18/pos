import 'package:flutter/material.dart';

import '../widgets/drawer_pos.dart';

class Ventas extends StatefulWidget {
  const Ventas({Key? key}) : super(key: key);

  @override
  _VentasState createState() => _VentasState();
}

class _VentasState extends State<Ventas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ventas"),),
      drawer: DrawerPos(),
      body: Text("Ventas en construcción"),
    );
  }
}
