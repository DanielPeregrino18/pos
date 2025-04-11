import 'package:flutter/material.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';

class Productos extends StatefulWidget {
  const Productos({Key? key}) : super(key: key);

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Productos"),),
      drawer: DrawerPos(),
      body: Text("productos en construcción"),
    );
  }
}
