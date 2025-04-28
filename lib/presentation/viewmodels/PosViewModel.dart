import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/config/DI/Dependencias.dart';
import 'package:pos/core/servicios/DetalleVentaServicio.dart';
import 'package:pos/core/servicios/ProductoServicio.dart';
import 'package:pos/data/modelos/detalleVenta.dart';
import 'package:pos/data/modelos/formaPago.dart';
import '../../data/modelos/producto.dart';


//Filtrado de productos en el buscador del punto de venta.
final inputSearchProvider = StateProvider<String>((ref) => '');

//Devuelve la lista de productos filtrados.
final productosFIltradosProvider = StateProvider<List<Producto>>((ref) {
    final inputSearch = ref.watch(inputSearchProvider);
    final productos = ref.watch(productoServicioProvider).getAllProductos();
    return productos.where((prod) => prod.nombre!.toLowerCase().contains(inputSearch.toLowerCase())).toList();
});

//carrito de compras y total
final carritoProvider = ChangeNotifierProvider<Carrito>((ref) =>
                Carrito(ref.read(detalleVentasServicioProvider),
                    ref.read(productoServicioProvider)));

class Carrito with ChangeNotifier{
    List<Map<String, dynamic>> carrito = []; //carrito de compras inicializado vacio.
    List<FormaPago> formasDePago = [
      FormaPago("Efectivo", 0, 0, TextEditingController()),
      FormaPago("Debito", 0, 0, TextEditingController()),
      FormaPago("Credito", 0, 0, TextEditingController()),
    ]; //Las formas de pago que se muestran inicialmente.
    double totalCarrito = 0.0;
    double totalPagado = 0.0;
    double restante = 0.0;
    double cambio = 0.0;
    DetalleVenta? ultimaVenta;

    final DetalleVentaServicio detalleVentaServicio;
    final ProductoServicio productoServicio;

    Carrito(this.detalleVentaServicio, this.productoServicio);

    //Agrega producto al carrito, si ya existe el producto, solo aaumenta la cantidad (si tiene stock disponible)
    void agregar(Producto producto){
      final index = carrito.indexWhere((prod) => prod["producto"].id == producto.id); //devuelve -1 si no existe
      if(index < 0){ // si es -1 no existe en el carrito y lo agrega.
        carrito.add({"producto" : producto , "cantidad" : 1, "total": producto.precio});
        totalCarrito += producto.precio!;
      }else{
        if(carrito[index]["cantidad"] < carrito[index]["producto"].stock) { //revisa si la cantidad no es igual o mayor al stock del producto
          carrito[index]["cantidad"] += 1; //sube la cantidad
          carrito[index]["total"] += producto.precio; //Aumenta el precio total del producto.
          totalCarrito += producto.precio!;
        }
      }
      restante = totalCarrito;
    }

    //Agrega una cantidad exacta de un producto en especifico del carrito de compras.
    void setCantidad(int index,int cantidad){
      totalCarrito -= carrito[index]["total"]; //se resta el total anterior anterior
      carrito[index]["cantidad"] = cantidad;
      carrito[index]["total"] = carrito[index]["producto"].precio * cantidad;
      totalCarrito += carrito[index]["total"]; //se suma la nueva cantidad
      restante = totalCarrito;
      notifyListeners();
    }

    //Reinica el punto de venta.
    void clear(){
      carrito.clear();
      totalCarrito = 0.0;
      restante = 0.0;
      cambio = 0.0;
      totalPagado = 0.0;
      formasDePago = [
        FormaPago("Efectivo", 0, 0, TextEditingController()),
        FormaPago("Debito", 0, 0, TextEditingController()),
        FormaPago("Credito", 0, 0, TextEditingController()),
      ];
      notifyListeners();
    }

    //Elimina un producto del carrito
    void delete(int index){
      totalCarrito -= carrito[index]["total"];
      carrito.removeAt(index);
      restante = totalCarrito;
      notifyListeners();
    }

    //Actualiza la ventana de metodos de pago cada que se agrega un valor, para poder observar el faltante o el cambio.
    void actualizarPagado(){
      totalPagado = formasDePago.fold(0, (total, formaPago) =>
                      total + formaPago.cantidad!,);
      restante = totalCarrito - totalPagado;
      restante = restante > 0? restante : 0;
      if(restante == 0){
        cambio = totalPagado - totalCarrito;
      }else{
        cambio = 0;
      }
      notifyListeners();
    }

    //Agrega una nueva forma de pago (debito o credito)
    void agregarFormaDePago(String tipoPago){
      int index = formasDePago.where((formaPago) => formaPago.tipo == tipoPago,).length;
      formasDePago.add(FormaPago(tipoPago, index, 0, TextEditingController()));
      notifyListeners();
    }

    //Elimina una forma de pago (debito o credito)
    void eliminarFormaDePago(String tipoPago, int index){
      formasDePago.where((formaPago) => formaPago.tipo == tipoPago && formaPago.index == index,)
                  .forEach((element) {
                    element.control!.dispose();
                  },);
      formasDePago.removeWhere((formaPago) => formaPago.tipo == tipoPago && formaPago.index == index,);
      actualizarPagado();
    }

    //Devuelve el indice del ultimo elemento de un tipo de pago en especifico.
    int getLastIndex(String tipoPago){
      return formasDePago.where((formaPago) => formaPago.tipo == tipoPago,).toList().length - 1;
    }


    //Devuelve el metodo de pago que se encuentra en un indice en especifico, y coincide con el tipo de pago del parametro.
    FormaPago getMetodoPago(String tipoPago, int index){
      return formasDePago.firstWhere((formaPago) => formaPago.tipo == tipoPago && formaPago.index == index,);
    }

    //Elimina todos los metodos de pago extra y se reinician los principales.
    void cancelarMetodosPago(){
        formasDePago.where((formaPago) => formaPago.index == 0,).forEach((formaPago) {
          formaPago.control!.clear();
          formaPago.setCantidad("0");
        },);
        formasDePago.where((formaPago) => formaPago.index != 0).forEach((formaPago) {
          formaPago.control!.dispose();
        },);
        formasDePago.removeWhere((formaPago) => formaPago.index != 0);
        actualizarPagado();
    }

    //Gurada la venta en la base de datos.
    bool generarVenta(){
       if (_validacionVenta()) {
          //Elimina las formas de pago que no se utilizaron
          formasDePago = formasDePago.where((formaPago) => formaPago.cantidad != 0,).toList();

          //Guarda la venta en la base de datos
          int idUltimaVenta = detalleVentaServicio.setDetalleVenta(carrito, formasDePago, totalCarrito, cambio);

          if(idUltimaVenta != -1){
            //Obtiene la venta para mostrarla en el ticket
            ultimaVenta = detalleVentaServicio.getDetalleVentaPorID(idUltimaVenta);
            clear();
            return true;
          }else{
            return false;
          }
       }
       return false;
    }

    //valida que los datos esten correctos para realizar la venta.
    bool _validacionVenta(){
      if(restante!= 0){
        return false;
      }
      if(cambio > 0.009){
        if(formasDePago[0].cantidad! < cambio){
          return false;
        }
      }
      if(_contienePagosAdicionalesVacios()){
        return false;
      }
      if(_contienePrincipalesVaciosYAdicionalesLlenos()){
        return false;
      }
      return true;
    }

    bool _contienePagosAdicionalesVacios(){
      return formasDePago.any((formaPago) => formaPago.index! > 0 && formaPago.cantidad == 0,);
    }

    bool _contienePrincipalesVaciosYAdicionalesLlenos(){
      bool adicionalesDebito = formasDePago.any((formaPago) => formaPago.index! > 0 &&
                                            formaPago.tipo == "Debito",);
      bool adicionalesCredito = formasDePago.any((formaPago) => formaPago.index! > 0 &&
          formaPago.tipo == "Credito",);

      if(adicionalesDebito && formasDePago[1].cantidad == 0){
        return true;
      }
      if(adicionalesCredito && formasDePago[2].cantidad == 0){
        return true;
      }
      return false;
    }


    //Devuelve los productos del ticket de la ultima venta realizada.
    List<Map<String, dynamic>> productosTicket(){
      return ultimaVenta!.productos.map((productoVenta) =>
        {"nombre":productoVenta.producto.target!.nombre,
          "cantidad" : productoVenta.cantidad,
          "precio": productoVenta.producto.target!.precio,
          "totalProducto": productoVenta.producto.target!.precio! * productoVenta.cantidad
        },).toList();
    }
}



