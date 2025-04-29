import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pos/presentation/viewmodels/PosViewModel.dart';

class ImpresionTicket extends ConsumerWidget {
  const ImpresionTicket({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Venta Realizada",
          style: TextStyle(
            fontSize: 40.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      "Ticket de Compra",
                      style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Center(child: Text("Ticket No. ${ref.read(carritoProvider).ultimaVenta!.id}", style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500))),
                  Center(child: Text("Fecha: ${formatter.format( ref.read(carritoProvider).ultimaVenta!.fecha!)}", style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500))),
                  SizedBox(height: 30),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          ref.read(carritoProvider).productosTicket().length,
                      itemBuilder: (context, index) {
                        List<Map<String, dynamic>> productos =
                            ref.read(carritoProvider).productosTicket();
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                productos[index]["nombre"],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25.sp),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Precio: \$${productos[index]["precio"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25.sp),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Cantidad: ${productos[index]["cantidad"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25.sp),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "\$${productos[index]["totalProducto"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25.sp),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text(
                    "Total: ${ref.read(carritoProvider).ultimaVenta!.total.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 30.sp),
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                        ref.read(carritoProvider).ultimaVenta!.metodoPago.length,
                      itemBuilder: (context, index) {
                        final metodosPago = ref.read(carritoProvider).ultimaVenta!
                                                            .metodoPago.toList();
                        String esTarjeta = metodosPago[index].tipo == "Efectivo" ? "" : "Tarjeta de ";
                        return Text("$esTarjeta${metodosPago[index].tipo} : ${metodosPago[index].cantidad!.toStringAsFixed(2)}", style: TextStyle(fontSize: 30.sp));
                      },
                    ),
                  ),
                  Text(
                    "Cambio: ${ref.read(carritoProvider).ultimaVenta!.cambio.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 30.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.white),
          onPressed: () {
            context.pop();
          },
          child: Text("Aceptar"),
        ),
      ),
    );
  }
}
