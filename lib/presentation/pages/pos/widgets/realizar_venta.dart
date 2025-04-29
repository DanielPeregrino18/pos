import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/data/modelos/formaPago.dart';
import 'package:pos/presentation/pages/pos/widgets/impresion_ticket.dart';
import 'package:pos/presentation/viewmodels/PosViewModel.dart';

class RealizarVenta extends ConsumerStatefulWidget {
  const RealizarVenta({Key? key}) : super(key: key);

  @override
  ConsumerState<RealizarVenta> createState() => _RealizarVentaState();
}

class _RealizarVentaState extends ConsumerState<RealizarVenta> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    var carrito = ref.read(carritoProvider.notifier);

    return AlertDialog(
      title: Center(
        child: Text(
          "Realizar Venta",
          style: TextStyle(fontSize: 35, color: theme.primary),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              child: Column(
                spacing: 25,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text("Efectivo", style: TextStyle(fontSize: 45.sp)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: TextField(
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'),
                              ),
                            ],
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onChanged: (value) {
                              carrito.formasDePago[0].setCantidad(value);
                              carrito.actualizarPagado();
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                    ],
                  ),
                  ...carrito.formasDePago
                      .where((formaPago) => formaPago.tipo == "Debito")
                      .map((e) => MetodoPago(e)),
                  ...carrito.formasDePago
                      .where((formaPago) => formaPago.tipo == "Credito")
                      .map((e) => MetodoPago(e)),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Total: \$${carrito.totalCarrito.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 35.sp, color: Colors.grey),
          ),
          Text(
            "Pagado: \$${ref.watch(carritoProvider).totalPagado.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 35.sp, color: Colors.grey),
          ),
          Text(
            "Restante: \$${ref.watch(carritoProvider).restante.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 35.sp, color: Colors.grey),
          ),
          Text(
            "Cambio: \$${ref.watch(carritoProvider).cambio.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 35.sp, color: Colors.grey),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            carrito.cancelarMetodosPago();
            context.pop();
          },
          child: Text("Cancelar"),
        ),
        TextButton(onPressed: () {
          if(carrito.generarVenta()){
            context.pop();
            showDialog(
                context: context, builder: (context) {
                  return Dialog.fullscreen(
                    child: ImpresionTicket(),
                  );
                },);

          }
        }, child: Text("Aceptar")),
      ],
    );
  }

  Row MetodoPago(FormaPago formaPago) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        formaPago.index! > 0
            ? Icon(Icons.subdirectory_arrow_right_sharp)
            : SizedBox(),
        Expanded(
          child: Text(
            "Tarjeta ${formaPago.tipo}",
            style: TextStyle(fontSize: 40.sp),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: TextField(
              controller: formaPago.control,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                formaPago.setCantidad(value);
                ref.read(carritoProvider).actualizarPagado();
              },
            ),
          ),
        ),
        if (formaPago.index == 0)
          IconButton(
            onPressed: () {
              ref
                  .read(carritoProvider.notifier)
                  .agregarFormaDePago(formaPago.tipo!);
            },
            icon: Icon(Icons.add_box_sharp),
            color: Colors.green,
            iconSize: 55.sp,
          )
        else
          formaPago.index! ==
                  ref
                      .watch(carritoProvider.notifier)
                      .getLastIndex(formaPago.tipo!)
              ? IconButton(
                onPressed: () {
                  ref
                      .read(carritoProvider.notifier)
                      .eliminarFormaDePago(formaPago.tipo!, formaPago.index!);
                  setState(() {});
                },
                icon: Icon(Icons.remove_circle_outlined),
                color: Colors.red,
                iconSize: 55.sp,
              )
              : SizedBox(width: 50),
      ],
    );
  }
}
