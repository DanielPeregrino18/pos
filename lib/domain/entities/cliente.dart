import 'package:objectbox/objectbox.dart';

@Entity()
class ClienteOB {
  @Id()
  int id;

  int id_Cliente;

  String razon_Social;

  String RFC;

  double descuento;

  int NO_Plazo;

  int id_lista;

  String cfdi;

  ClienteOB({
    this.id = 0,
    required this.id_Cliente,
    required this.razon_Social,
    required this.RFC,
    required this.descuento,
    required this.NO_Plazo,
    required this.id_lista,
    required this.cfdi,
  });
}
