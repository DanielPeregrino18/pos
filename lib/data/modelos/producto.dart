
import 'package:objectbox/objectbox.dart';

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
      "precio": format(precio!),
      "stock": "$stock"
    };
  }

  String format(double n) {
    return n.toStringAsFixed( 2);
  }
}