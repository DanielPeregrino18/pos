import 'package:pos/data/modelos/producto.dart';
import 'package:pos/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pos/data/modelos/detalleVenta.dart';



class ObjectboxConnection{
  late final Store _store;

  late final Box<Producto> produtoBox;
  late final Box<DetalleVenta> detalleVentaBox;

  ObjectboxConnection._create(this._store) {
    produtoBox = Box<Producto>(_store);
    detalleVentaBox = Box<DetalleVenta>(_store);
  }
  static Future<ObjectboxConnection> create() async {
    final store = await openStore(
        directory:
        p.join((await getApplicationDocumentsDirectory()).path, "obx-demo"),
        macosApplicationGroup: "objectbox.demo");
    return ObjectboxConnection._create(store);
  }

}