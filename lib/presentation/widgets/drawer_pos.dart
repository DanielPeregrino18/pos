import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/viewmodels/LoginViewModel.dart';

class DrawerPos extends ConsumerWidget {
  const DrawerPos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  context.go("/pos");
                },
                label: Text("Punto de venta", style: TextStyle(fontSize: 20)),
                icon: Icon(Icons.add_shopping_cart, size: 20),
              ),
              SizedBox(height: 10,),
              TextButton.icon(
                onPressed: () {
                  context.go("/productos");
                },
                label: Text("Productos", style: TextStyle(fontSize: 20)),
                icon: Icon(Icons.dashboard_customize_outlined, size: 20),
              ),
              SizedBox(height: 10,),
              TextButton.icon(
                onPressed: () {
                  context.go("/ventas");
                },
                label: Text("Ventas", style: TextStyle(fontSize: 20)),
                icon: Icon(Icons.analytics_outlined, size: 20),
              ),
              SizedBox(height: 10,),
              TextButton.icon(
                onPressed: () {
                  context.go("/ajustes");
                },
                label: Text("Ajustes", style: TextStyle(fontSize: 20)),
                icon: Icon(Icons.settings, size: 20),
              ),
              SizedBox(height: 30,),
              Divider(),
              TextButton.icon(
                onPressed: () {
                  ref.read(loginStateProvider).logout();
                  context.go("/");
                },
                label: Text("Cerrar Sesión", style: TextStyle(fontSize: 20, color: Colors.red)),
                icon: Icon(Icons.exit_to_app, size: 20, color: Colors.red,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
