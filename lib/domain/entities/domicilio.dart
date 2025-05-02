import 'package:objectbox/objectbox.dart';

@Entity()
class DomicilioOB {
  @Id()
  int id;

  int id_Cliente;
  String domicilio;
  String colonia;
  String ciudad;
  String c_p;
  int plazo;
  String estado;

  DomicilioOB({
    this.id = 0,
    required this.id_Cliente,
    required this.domicilio,
    required this.colonia,
    required this.ciudad,
    required this.c_p,
    required this.plazo,
    required this.estado,
  });
}
