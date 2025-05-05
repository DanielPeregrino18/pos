import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/data/modelos/api_service_response_models/api_clientes_response.dart';
import 'package:pos/presentation/pages/clientes/clientes.dart';
import 'package:pos/presentation/viewmodels/ClientesViewModel.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';
import 'package:pos/data/modelos/api_service_response_models/models.dart';
import 'package:pos/domain/entities/entities.dart';
import 'package:pos/presentation/viewmodels/general_data/general_data.dart';
import 'package:pos/presentation/viewmodels/general_purpose.dart';

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

  _guardarClientes(List<Cliente> clientes) {
    if (clientes.isNotEmpty) {
      for (Cliente cliente in clientes) {
        ClienteOB clienteOB = ClienteOB(
          id_Cliente: cliente.id_Cliente,
          razon_Social: cliente.razon_Social,
          RFC: cliente.RFC,
          descuento: cliente.descuento,
          NO_Plazo: cliente.NO_Plazo,
          id_lista: cliente.id_lista,
          cfdi: cliente.cfdi,
        );

        bool result = ref.read(clientesVMProvider).agregarCliente(clienteOB);

        if (result == false) {
          debugPrint("Cliente no registrado, RFC duplicado: ${clienteOB.RFC}");
        }
      }
    } else {
      debugPrint("No hay clientes para guardar");
    }
  }

  _guardarAlmacenes(List<Almacen> almacenes) {
    if (almacenes.isNotEmpty) {
      for (Almacen alm in almacenes) {
        AlmacenOB almacenOB = AlmacenOB(
          id_almacen: alm.id_almacen,
          nombre: alm.nombre,
          nombreOrden: alm.nombreOrden,
        );

        bool result = ref.read(almacenesVMProvider).agregarAlmacen(almacenOB);

        if (result == false) {
          debugPrint("Almacen no registrado, id_almacen duplicado: ${almacenOB.id_almacen}");
        }
      }
    } else {
      debugPrint("No hay almacenes para guardar");
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    List<ApiClientesResponse> datos = ref.watch(clientesProvider);

    return Scaffold(
      appBar: ClientesAppBar(theme: theme),
      drawer: DrawerPos(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                  padding: const EdgeInsets.all(15),
                  child: SearchAnchor.bar(
                    dividerColor: theme.primary,
                    viewBackgroundColor: theme.onPrimary,
                    barHintText: "Buscar cliente por RFC",
                    viewConstraints: BoxConstraints(
                      minWidth: 550.0,
                      minHeight: 0,
                      maxHeight: 58,
                    ),
                    suggestionsBuilder: (context, controller) {
                      if (controller.text.isEmpty) {
                        return <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Center(child: Text("No hay historial")),
                          ),
                        ];
                      }
                      ref.read(inputSearchProvider.notifier).state =
                          controller.value.text;
                      final clientesFiltradosProvider = ref.read(
                        clientesFiltradosProv,
                      );
                      return clientesFiltradosProvider.map(
                        (clienteOB) => ListTile(
                          title: Text(
                            'ID cliente: ${clienteOB.id_Cliente}',
                            style: TextStyle(
                              fontSize: 25,
                              color: theme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            children: [
                              Text(
                                "Razón Social: ${clienteOB.razon_Social}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "RFC: ${clienteOB.RFC}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          onTap: () {
                            controller.clear();
                            context.pop();
                          },
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 120.sp,
              height: 120.sp,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () {
                    if (datos.isEmpty) {
                      debugPrint("No hay datos para guardar");
                      return;
                    }
                    // _guardarClientes(datos[0].clientes);
                    _guardarAlmacenes(datos[0].almacenes);
                  },
                  tooltip: "Guardar datos",
                  child: Icon(Icons.save),
                ),
              ),
            ),
            SizedBox(
              width: 120.sp,
              height: 120.sp,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {
                    _cargarDatos();
                  },
                  tooltip: "Cargar datos",
                  child: Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
