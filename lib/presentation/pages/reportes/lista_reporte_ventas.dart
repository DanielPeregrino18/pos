import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pos/data/modelos/Venta.dart';

import '../../viewmodels/ReporteVentasViewModel.dart';

class ListaReporteVentas extends ConsumerStatefulWidget {
  const ListaReporteVentas({super.key});

  @override
  ConsumerState<ListaReporteVentas> createState() => _ListaReporteVentasState();
}

class _ListaReporteVentasState extends ConsumerState<ListaReporteVentas> {
  List<int> data = [];
  int currentLength = 0;
  final int increment = 10;
  bool isLoading = false;

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });

    // dummy delay
    await new Future.delayed(const Duration(seconds: 2));
    for (var i = currentLength; i <= currentLength + increment; i++) {
      data.add(i);
    }
    setState(() {
      isLoading = false;
      currentLength = data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      isLoading: isLoading,
      onEndOfPage: () => ref.read(reporteVentasVMProvider).cargarMas(),
      child: ListView.builder(
        itemCount:
            ref.watch(reporteVentasVMProvider).ventasMostradas.length + (ref.watch(reporteVentasVMProvider).allVentas.isNotEmpty?1:0),
        itemBuilder: (context, position) {
          if (position ==
              ref.watch(reporteVentasVMProvider).ventasMostradas.length &&
              ref.watch(reporteVentasVMProvider).allVentas.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 44,
                  width: 44,
                ),
              ),
            );
          }
          return VentaItem(position: position);
        },
      ),
    );
  }
}

class VentaItem extends ConsumerWidget {
  final int position;

  const VentaItem({super.key, required this.position});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Venta venta = ref.watch(reporteVentasVMProvider).ventasMostradas[position];
    var theme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.shopify_sharp, size: 30),
                SizedBox(width: 8.0),
                Text("Venta $position", style: TextStyle(fontSize: 30, color: theme.primary)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    "Zona: ${venta.ID_ZONA}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    "ID Sucursal: ${venta.ID_SUCURSAL}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    "ID Tipo: ${venta.ID_TIPO}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Año: ${venta.YEAR}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    "Mes: ${venta.MES}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Semana: ${venta.SEMANA}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Movimientos: ${venta.MOVIMIENTOS}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Valor: ${venta.VALOR}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    "Valor USD: ${venta.VALOR_USD}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Filial: ${venta.FILIAL}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Cantidad: ${venta.CANTIDAD}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Cancelado: ${venta.CANCELADO}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
