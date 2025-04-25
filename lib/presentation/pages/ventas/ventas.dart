import 'package:custom_accordion/custom_accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pos/presentation/viewmodels/VentasViewModel.dart';

import '../../../data/modelos/detalleVenta.dart';
import '../../widgets/drawer_pos.dart';

class Ventas extends ConsumerStatefulWidget {
  const Ventas({Key? key}) : super(key: key);

  @override
  ConsumerState<Ventas> createState() => _VentasState();
}

class _VentasState extends ConsumerState<Ventas> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ventas",
          style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.onPrimary),
        backgroundColor: theme.primary,
      ),
      drawer: DrawerPos(),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        itemCount: ref.watch(ventasVMProvider).getAllDetallesVentas().length,
        itemBuilder: (context, index) {
          List<Map<String, dynamic>> productosCantidades = ref
              .watch(ventasVMProvider)
              .getProductosPorIndex(index);
          List<MetodoPago> metodosPago = ref
              .watch(ventasVMProvider)
              .getMetodoPagoPorIndex(index);

          List<Text> productosText =
              productosCantidades
                  .map(
                    (e) => Text(
                      "${e["cantidad"]} ${e["nombre"]} \$${e["totalProducto"]}",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                  .toList();
          List<Text> metodoPagoText =
              metodosPago
                  .map(
                    (e) => Text(
                      "${e.tipo == "Efectivo" ? "" : "Tarjeta"} ${e.tipo} \$${e.cantidad}",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                  .toList();
          return CustomAccordion(
            title:
                "Venta ${ref.watch(ventasVMProvider).todasLasVentas[index].id}",
            subTitle: formatter.format(
              ref.watch(ventasVMProvider).todasLasVentas[index].fecha!,
            ),
            headerBackgroundColor: theme.primary,
            titleStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            subTitleStyle: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            toggleIconOpen: Icons.keyboard_arrow_down_sharp,
            toggleIconClose: Icons.keyboard_arrow_up_sharp,
            headerIconColor: Colors.white,
            accordionElevation: 10,
            showContent: false,
            widgetItems: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Productos",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      ...productosText,
                      Text(
                        "Total: ${ref.watch(ventasVMProvider).todasLasVentas[index].total.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Metodos de Pago",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      ...metodoPagoText,
                      Text(
                        "Cambio: ${ref.watch(ventasVMProvider).todasLasVentas[index].cambio.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
