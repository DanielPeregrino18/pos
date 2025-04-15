
import 'package:objectbox/objectbox.dart';

@Entity()
class Producto {
  @Id()
  int id = 0;
  String? nombre;
  double? precio;

  int stock;

  Producto(this.nombre, this.precio, this.stock);
}