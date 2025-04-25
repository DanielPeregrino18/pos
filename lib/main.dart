import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DB/ObjectboxConnection.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/routes/routes.dart';
Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();
  final objectbox = await ObjectboxConnection.create();
  //client.loggin(UserModel("pruebas_rrj@rrj.com.mx", "Ads720510.")).then((value) {print(value.Email);});

  runApp(ProviderScope(
      overrides: [
        objectBoxProvider.overrideWithValue(objectbox)
      ],
      child: MyApp()
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "POS",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ref.watch(colorSchemeProvider)
      ),
      routerConfig: ref.read(routerProvider),
    );
  }
}