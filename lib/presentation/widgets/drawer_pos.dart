import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/viewmodels/LoginViewModel.dart';

class DrawerPos extends ConsumerWidget {
  const DrawerPos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15.sp,
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () {
                      context.go("/pos");
                    },
                    label: Text("Punto de venta", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.add_shopping_cart, size: 30),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.go("/productos");
                    },
                    label: Text("Productos", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.dashboard_customize_outlined, size: 30),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.go("/ventas");
                    },
                    label: Text("Ventas", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.analytics_outlined, size: 30),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.go("/ajustes");
                    },
                    label: Text("Ajustes", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.settings, size: 30),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.go("/reportes");
                    },
                    label: Text("Reportes", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.feed_sharp, size: 30),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.go("/datos");
                    },
                    label: Text("Datos", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.data_saver_on, size: 30),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.go("/almacenes");
                    },
                    label: Text("Almacenes", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.store, size: 30),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.go("/clientes");
                    },
                    label: Text("Clientes", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.person, size: 30),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.go("/monedas");
                    },
                    label: Text("Monedas", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.monetization_on, size: 30),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      context.go("/domicilios");
                    },
                    label: Text("Domicilios", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.home, size: 30),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.go("/vendedores");
                    },
                    label: Text("Vendedores", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.groups, size: 30),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.go("/cifras");
                    },
                    label: Text("Cifras", style: TextStyle(fontSize: 30.sp)),
                    icon: Icon(Icons.numbers, size: 30),
                  ),
                  Divider(),
                  TextButton.icon(
                    onPressed: () {
                      ref.read(loginStateProvider).logout();
                      context.go("/");
                    },
                    label: Text("Cerrar Sesión", style: TextStyle(fontSize: 30.sp, color: Colors.red)),
                    icon: Icon(Icons.exit_to_app, size: 30, color: Colors.red,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
