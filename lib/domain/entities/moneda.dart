import 'package:objectbox/objectbox.dart';

@Entity()
class MonedaOB {
  @Id()
  int id;

  int IdMoneda;

  String Nombre;

  String Clave_SAT;

  MonedaOB({
    this.id = 0,
    required this.IdMoneda,
    required this.Nombre,
    required this.Clave_SAT,
  });
}
