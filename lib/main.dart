import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/config/DB/ObjectboxConnection.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/routes/routes.dart';
Future<void> main() async {

  //Se usa esta linea si flutter necesita llamar al código nativo antes de llamar run app
  WidgetsFlutterBinding.ensureInitialized();
  //Inicializa la conexion con la base de datos
  final objectbox = await ObjectboxConnection.create();

  runApp(ProviderScope( //Permite accesar a los proveedores desde cualquier parte de la aplicacion.
      overrides: [
        objectBoxProvider.overrideWithValue(objectbox) //Sobrescribe el proveedor de objectbox (dependencias)
      ],
      child: MyApp()
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtil.init(context, designSize: Size(800, 1280), minTextAdapt: true);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "POS",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ref.watch(colorSchemeProvider)  //Obtiene el tema del proveedor de estados
      ),
      routerConfig: ref.read(routerProvider), //Obtiene las rutas del proveedor
    );
  }
}