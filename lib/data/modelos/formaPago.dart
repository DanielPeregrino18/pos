
import 'package:flutter/cupertino.dart';

//Se utiliza para generar los textfield de metodos de pago en el punto de venta.
class FormaPago {

  int id = 0;
  String? tipo;

  int? index;
  double? cantidad;

  TextEditingController? control;


  FormaPago(this.tipo,this.index, this.cantidad, this.control);

  void setCantidad(String cantidad){
    if(cantidad == "" || cantidad.isEmpty){
      this.cantidad = 0;
    } else {
      this.cantidad = double.parse(cantidad);
    }
  }

  @override
  String toString() {
    return "Tipo: ${this.tipo}, Index: ${this.index}, Cantidad: ${this.cantidad}";
  }
}