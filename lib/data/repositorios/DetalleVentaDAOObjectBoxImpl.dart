

import 'package:pos/core/dao/DetalleVentaDAO.dart';
import 'package:pos/data/modelos/detalleVenta.dart';
import '../../config/DB/ObjectboxConnection.dart';

class DetalleVentaDAOObjectBoxImpl extends DetalleVentaDAO{

  final ObjectboxConnection _connectionDB;
  DetalleVentaDAOObjectBoxImpl(this._connectionDB);

  @override
  List<DetalleVenta> getAllDetallesVentas() {
    final _detalleVentaDB = _connectionDB.detalleVentaBox;
    return _detalleVentaDB.getAll();
  }

  @override
  DetalleVenta? getDetalleVentaPorID(int id) {
    final _detalleVentaDB = _connectionDB.detalleVentaBox;
    return _detalleVentaDB.get(id);
  }

  @override
  int setDetalleVenta(DetalleVenta detalleVenta) {
    final _detalleVentaDB = _connectionDB.detalleVentaBox;
    try{
      return _detalleVentaDB.put(detalleVenta);
    }catch (e){
      return -1;
    }
  }

}