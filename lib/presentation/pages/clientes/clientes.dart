import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/data/modelos/api_service_response_models/api_clientes_response.dart';
import 'package:pos/presentation/viewmodels/ClientesViewModel.dart';

class Clientes extends ConsumerStatefulWidget {
  const Clientes({super.key});

  @override
  ConsumerState<Clientes> createState() => _ClientesState();
}

class _ClientesState extends ConsumerState<Clientes> {
  late bool isLoading;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  _isLoading() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  _cargarDatos() async {
    setState(() {
      isLoading = true;
    });

    await ref
        .read(clientesProvider.notifier)
        .fetchClients(
          5,
          2,
          'Data Source=rrjipfija.ddns.net;Initial Catalog=RRJ_TEST;Persist Security Info=True;User ID=sergio;Password=Akamai24;Connect Timeout=180;',
        );

    _isLoading();
  }

  @override
  Widget build(BuildContext context) {
    List<ApiClientesResponse> datos = ref.watch(clientesProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Clientes')),
        body: Center(
          child: isLoading ? CircularProgressIndicator() : Container(),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            _cargarDatos();
            debugPrint('Datos is empty: ${datos.isEmpty}');
          },
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}
