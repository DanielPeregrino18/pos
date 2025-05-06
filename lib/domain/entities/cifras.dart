import 'package:objectbox/objectbox.dart';

@Entity()
class CifrasOB {
  @Id()
  int id;

  double paridad;

  int idMovC;

  int idMovP;

  CifrasOB({
    this.id = 0,
    required this.paridad,
    required this.idMovC,
    required this.idMovP,
  });
}
