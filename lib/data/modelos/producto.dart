
import 'package:objectbox/objectbox.dart';

//Modelo de productos a la venta.
@Entity()
class Producto {
  @Id()
  int id = 0;
  String? nombre;
  double? precio;

  int stock;

  Producto(this.nombre, this.precio, this.stock);

  Map<String,String> toMap (){
    return {
      "id": "$id",
      "nombre": nombre!,
      "precio": precio!.toStringAsFixed(2),
      "stock": "$stock"
    };
  }

}