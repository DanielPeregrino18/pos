
import 'package:objectbox/objectbox.dart';

@Entity()
class Producto {
  @Id()
  int id = 0;
  String? name;

  Producto();
}