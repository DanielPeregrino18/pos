import 'package:objectbox/objectbox.dart';

@Entity()
class AlmacenOB {
  @Id()
  int id;

  int id_almacen;

  String nombre;

  String nombreOrden;

  AlmacenOB({
    this.id = 0,
    required this.id_almacen,
    required this.nombre,
    required this.nombreOrden,
  });
}
