

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pos/core/dao/DetalleVentaDAO.dart';
import 'package:pos/core/dao/ProductoDAO.dart';
import 'package:pos/core/encriptado/SecureStorage.dart';
import 'package:pos/core/servicios/DetalleVentaServicio.dart';
import 'package:pos/core/servicios/ProductoServicio.dart';
import 'package:pos/data/repositorios/DetalleVentaDAOObjectBoxImpl.dart';
import 'package:pos/data/repositorios/ProductoDAOObjectboxImpl.dart';
import '../../data/modelos/Claim.dart';
import '../DB/ObjectboxConnection.dart';


final objectBoxProvider = Provider<ObjectboxConnection>((ref) => throw UnimplementedError());

//DIO
final DioProvider = Provider<Dio>((ref){
  final dio = Dio();
  dio.options.headers['Demo-Header'] = 'demo header';
  return dio;
},);

//LOGGIN
final loginApiProvider = Provider<ClaimApi>((ref) =>
                                          ClaimApi(ref.read(DioProvider)),);
//Productos
final productoDAOImplProvider = Provider<ProductoDao>((ref) =>
                  ProductoDAOObjectboxImpl(ref.read(objectBoxProvider)),);

final productoServicioProvider = Provider<ProductoServicio>((ref) =>
                      ProductoServicio(ref.read(productoDAOImplProvider)),);

//DETALLES VENTAS
final detalleVentasDAOImplProvider = Provider<DetalleVentaDAO>((ref) =>
                      DetalleVentaDAOObjectBoxImpl(ref.read(objectBoxProvider)),);
final detalleVentasServicioProvider = Provider<DetalleVentaServicio>((ref) =>
                      DetalleVentaServicio(ref.read(detalleVentasDAOImplProvider)) ,);


//SECURE STORAGE
final FlutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) =>
                                                          const FlutterSecureStorage(),);

final secureStorageProvider = Provider<SecureStorage>((ref) =>
                            SecureStorage(ref.read(FlutterSecureStorageProvider)));