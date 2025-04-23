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


  runApp(ProviderScope(
      overrides: [
        objectBoxProvider.overrideWithValue(objectbox)
      ],
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "POS",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
      ),
      routerConfig: router,
    );
  }
}