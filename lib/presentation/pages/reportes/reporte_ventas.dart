import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pos/presentation/pages/reportes/lista_reporte_ventas.dart';
import 'package:pos/presentation/viewmodels/ReporteVentasViewModel.dart';

import '../../widgets/drawer_pos.dart';

class ReporteVentas extends ConsumerStatefulWidget {
  const ReporteVentas({Key? key}) : super(key: key);

  @override
  ConsumerState<ReporteVentas> createState() => _ReporteVentasState();
}

class _ReporteVentasState extends ConsumerState<ReporteVentas> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reporte de ventas",
          style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.onPrimary),
        backgroundColor: theme.primary,
      ),
      drawer: DrawerPos(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: ref.watch(reporteVentasVMProvider).fechaInicio,
                    firstDate: DateTime(2015),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null &&
                      picked != ref.read(reporteVentasVMProvider).fechaInicio) {
                    setState(() {
                      ref.read(reporteVentasVMProvider).fechaInicio = picked;
                    });
                  }
                },
                label: Text(
                  formatter.format(ref.read(reporteVentasVMProvider).fechaInicio),
                  style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600),
                ),
                icon: Icon(Icons.calendar_month, size: 30),
              ),
              Text(
                "al",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.primary,
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: ref.watch(reporteVentasVMProvider).fechaFin,
                    firstDate: DateTime(2015),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null &&
                      picked != ref.read(reporteVentasVMProvider).fechaFin) {
                    setState(() {
                      ref.read(reporteVentasVMProvider).fechaFin = picked;
                    });
                  }
                },
                label: Text(
                  formatter.format(ref.read(reporteVentasVMProvider).fechaFin),
                  style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600),
                ),
                icon: Icon(Icons.calendar_month, size: 30),
              ),
            ],
          ),
          Expanded(
            child:
                loading
                    ? Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                        height: 24,
                        width: 24,
                      ),
                    )
                    : ListaReporteVentas(),
          ),
        ],
      ),
      floatingActionButton: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: theme.primary,
          elevation: 15,
          iconSize: 40.sp,
          padding: EdgeInsets.all(20),
        ),
        onPressed: () async {
          setState(() {
            loading = true;
          });
          await ref.read(reporteVentasVMProvider).obtenerVentas();
          setState(() {
            loading = false;
          });
        },
        icon: Icon(Icons.search, color: theme.onPrimary),
      ),
    );
  }
}
