
import 'package:objectbox/objectbox.dart';
import 'package:pos/data/modelos/producto.dart';


//Entidad para guardar las ventas del pos.
@Entity()
class DetalleVenta{
  @Id()
  int id = 0;

  //Lista de metodos de pago utilizados en la venta
  final metodoPago = ToMany<MetodoPago>();

  //Productos y cantidades que se vendieron.
  final productos = ToMany<ProductoVenta>();

  double total;

  double cambio;

  @Property(type: PropertyType.date)
  DateTime? fecha;

  DetalleVenta(this.fecha, this.total, this.cambio);

}

//Entidad que hace referencia a que producto se vendio y cual fue la cantidad vendida.
@Entity()
class ProductoVenta{
  @Id()
  int id = 0;
  final  producto = ToOne<Producto>();
  int cantidad;
  ProductoVenta(this.cantidad);
}


//Entidad que almacena los metodos de pago con de una venta.
//los tipos son efectivo, debito, credito.
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

