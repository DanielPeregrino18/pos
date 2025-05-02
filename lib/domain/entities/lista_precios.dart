import 'package:objectbox/objectbox.dart';

@Entity()
class ListaPreciosOB {
  @Id()
  int id;

  int ID_LISTA;

  String NOMBRE;

  ListaPreciosOB({this.id = 0, required this.ID_LISTA, required this.NOMBRE});
}
