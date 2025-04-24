
import 'package:objectbox/objectbox.dart';
import 'package:pos/data/modelos/producto.dart';

@Entity()
class DetalleVenta{
  @Id()
  int id = 0;


  final metodoPago = ToMany<MetodoPago>();
  final productos = ToMany<ProductoVenta>();

  double total;

  double cambio;

  @Property(type: PropertyType.date)
  DateTime? fecha;

  DetalleVenta(this.fecha, this.total, this.cambio);

}
@Entity()
class ProductoVenta{
  @Id()
  int id = 0;
  final  producto = ToOne<Producto>();
  int cantidad;
  ProductoVenta(this.cantidad);
}

@Entity()
class MetodoPago{
  @Id()
  int id = 0;

  String? tipo;
  int? index;
  double? cantidad;
  final detalleVenta = ToOne<DetalleVenta>();

  MetodoPago(this.tipo, this.index, this.cantidad);

}

