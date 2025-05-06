import 'package:objectbox/objectbox.dart';

@Entity()
class VendedorOB {
  @Id()
  int id;

  int id_Usuario;

  String nombre;

  VendedorOB({this.id = 0, required this.id_Usuario, required this.nombre});
}
