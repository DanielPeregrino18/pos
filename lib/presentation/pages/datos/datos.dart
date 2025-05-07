import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/presentation/viewmodels/ClientesViewModel.dart';
import 'package:pos/data/modelos/api_service_response_models/models.dart';
import 'package:pos/data/modelos/api_service_response_models/api_clientes_response.dart';
import 'package:pos/domain/entities/entities.dart';
import 'package:pos/presentation/viewmodels/general_data/general_data.dart';
import 'package:pos/presentation/widgets/drawer_pos.dart';
import 'package:pos/presentation/widgets/general_app_bar.dart';

class Datos extends ConsumerStatefulWidget {
  const Datos({super.key});

  @override
  ConsumerState<Datos> createState() => _DatosState();
}

class _DatosState extends ConsumerState<Datos> {
  bool isLoading = false;

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

  _guardarAlmacenes(List<Almacen> almacenes) {
    if (almacenes.isNotEmpty) {
      int i = 1;
      for (Almacen alm in almacenes) {
        AlmacenOB almacenOB = AlmacenOB(
          id_almacen: alm.id_almacen,
          nombre: alm.nombre,
          nombreOrden: alm.nombreOrden,
        );

        bool result = ref.read(almacenesVMProvider).agregarAlmacen(almacenOB);

        if (result == false) {
          debugPrint(
            "Almacen no registrado, id_almacen duplicado: ${almacenOB.id_almacen}",
          );
        } else {
          debugPrint("Guardando almacenes...${i++}/${almacenes.length}");
        }
      }
    } else {
      debugPrint("No hay almacenes para guardar");
    }
  }

  _guardarPrioridades(List<dynamic> prioridades) {
    if (prioridades.isNotEmpty) {
      // Lógica para almacenar las prioridades
    } else {
      debugPrint("No hay prioridades para guardar");
    }
  }

  _guardarClientes(List<Cliente> clientes) {
    if (clientes.isNotEmpty) {
      int i = 1;
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
          debugPrint(
            "Cliente no registrado, id_Cliente duplicado: ${clienteOB.id_Cliente}",
          );
        } else {
          debugPrint("Guardando clientes...${i++}/${clientes.length}");
        }
      }
    } else {
      debugPrint("No hay clientes para guardar");
    }
  }

  _guardarMonedas(List<Moneda> monedas) {
    if (monedas.isNotEmpty) {
      for (Moneda moneda in monedas) {
        MonedaOB monedaOB = MonedaOB(
          IdMoneda: moneda.IdMoneda,
          Nombre: moneda.Nombre,
          Clave_SAT: moneda.Clave_SAT,
        );

        bool result = ref.read(monedaVMProvider).agregarMoneda(monedaOB);

        if (result == false) {
          debugPrint(
            "Moneda no registrada, id_Moneda duplicada: ${monedaOB.IdMoneda}",
          );
        }
      }
    } else {
      debugPrint("No hay monedas para guardar");
    }
  }

  _guardarListaPrecios(List<ListaPrecios> listaPrecios) {
    if (listaPrecios.isNotEmpty) {
      for (ListaPrecios precio in listaPrecios) {
        ListaPreciosOB precioOB = ListaPreciosOB(
          ID_LISTA: precio.ID_LISTA,
          NOMBRE: precio.NOMBRE,
        );

        bool result = ref
            .read(listaPreciosVMProvider)
            .agregarPrecioLDB(precioOB);

        if (result == false) {
          debugPrint(
            "Precio no registrado, ID_LISTA duplicado: ${precioOB.ID_LISTA}",
          );
        }
      }
    } else {
      debugPrint("No hay precios para guardar");
    }
  }

  _guardarTipoEntrega(List<dynamic> tipoEntrega) {
    if (tipoEntrega.isNotEmpty) {
      // Lógica para almacenar los tipos de entregas
    } else {
      debugPrint("No hay tipos de entrega para guardar");
    }
  }

  _guardarDomicilios(List<Domicilio> domicilios) {
    if (domicilios.isNotEmpty) {
      int i = 1;
      for (Domicilio domicilio in domicilios) {
        DomicilioOB domicilioOB = DomicilioOB(
          id_Cliente: domicilio.id_Cliente,
          domicilio: domicilio.domicilio,
          colonia: domicilio.colonia,
          ciudad: domicilio.ciudad,
          c_p: domicilio.c_p,
          plazo: domicilio.plazo,
          estado: domicilio.estado,
        );

        bool result = ref
            .read(domiciliosVMProvider)
            .agregarDomicilioLDB(domicilioOB);

        if (result == false) {
          debugPrint("Error: Precio no registrado");
        } else {
          debugPrint("Guardando domicilios...${i++}/${domicilios.length}");
        }
      }
    } else {
      debugPrint("No hay domicilios para guardar");
    }
  }

  _guardarVendedores(List<Vendedor> vendedores) {
    if (vendedores.isNotEmpty) {
      for (Vendedor vendedor in vendedores) {
        VendedorOB vendedorOB = VendedorOB(
          id_Usuario: vendedor.id_Usuario,
          nombre: vendedor.nombre,
        );

        bool result = ref.read(vendedorVMProvider).agregarVendedor(vendedorOB);

        if (result == false) {
          debugPrint(
            "Vendedor no id_Usuario duplicado: ${vendedorOB.id_Usuario}",
          );
        }
      }
    } else {
      debugPrint("No hay domicilios para guardar");
    }
  }

  _guardarCifras(double paridad, int idMovC, int idMovp) {
    CifrasOB cifrasOB = CifrasOB(
      paridad: paridad,
      idMovC: idMovC,
      idMovP: idMovp,
    );

    try {
      bool result = ref.read(cifrasVMProvider).agregarCifras(cifrasOB);

      if (result == false) {
        debugPrint("Error: cifras no registradas");
      }
    } catch (e) {
      debugPrint("Error: cifras no registradas");
    }
  }

  void _guardarDatos(List<ApiClientesResponse> datos) {
    setState(() {
      isLoading = true;
    });
    try {
      /*
      1. Almacenes
      2. Prioridades *
      3. Clientes
      4. Monedas
      5. Lista de precios
      6. Tipo de entrega *
      7. Domicilios
      8. Vendedores
      9. paridad
      10. idMovC
      11. idMovP
      */

      _guardarAlmacenes(datos[0].almacenes);
      _guardarPrioridades(datos[0].prioridades);
      // _guardarClientes(datos[0].clientes);
      _guardarMonedas(datos[0].moneda);
      _guardarListaPrecios(datos[0].lista_precios);
      _guardarTipoEntrega(datos[0].tipo_entrega);
      // _guardarDomicilios(datos[0].domicilios);
      _guardarVendedores(datos[0].vendedores);
      _guardarCifras(datos[0].paridad, datos[0].idMovC, datos[0].idMovP);
    } catch (e) {
      debugPrint('$e');
    }
    _isLoading();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    List<ApiClientesResponse> datos = ref.watch(clientesProvider);

    return Scaffold(
      appBar: GeneralAppBar(theme: theme, title: "Datos"),
      drawer: DrawerPos(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child:
              isLoading
                  ? CircularProgressIndicator()
                  : Icon(Icons.filter_list, color: theme.primary, size: 50),
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
                    _guardarDatos(datos);
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
