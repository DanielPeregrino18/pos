import 'package:flutter/material.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';

class POS extends StatefulWidget {
  const POS({Key? key}) : super(key: key);

  @override
  _POSState createState() => _POSState();
}

class _POSState extends State<POS> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppbarPos(theme),
      drawer: DrawerPos(),
    );
  }

  AppBar AppbarPos(ColorScheme theme) {
    return AppBar(
      title: Text(
        "Punto de venta",
        style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: theme.onPrimary),
      backgroundColor: theme.primary,
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 40)),
      ],
    );
  }
}
