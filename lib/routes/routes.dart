import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:pos/presentation/pages/ajustes/ajustes.dart';
import 'package:pos/presentation/pages/clientes/clientes.dart';
import 'package:pos/presentation/pages/login/login.dart';
import 'package:pos/presentation/pages/productos/update_producto.dart';
import 'package:pos/presentation/pages/reportes/reporte_ventas.dart';
import 'package:pos/presentation/pages/ventas/ventas.dart';
import 'package:pos/presentation/viewmodels/LoginViewModel.dart';
import '../presentation/pages/pos/p_o_s.dart';
import '../presentation/pages/productos/add_producto.dart';
import '../presentation/pages/productos/productos.dart';

//Proveedor de rutas de la aplicacion.
final routerProvider = Provider<GoRouter>((ref) {

  final GoRouter _router = GoRouter(
    routerNeglect: true,
    initialLocation: "/clientes", //Ruta inicial de la aplicación
    routes: <RouteBase>[
      GoRoute(
        path: '/',   //ruta
        builder: (BuildContext context, GoRouterState state) {
            return const Login();  //pagina a la que te redirige
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'pos',
            builder: (BuildContext context, GoRouterState state) {
              return const POS();
            },
          ),
          GoRoute(
              path: 'productos',
              builder: (context, state) {
                return const Productos();
              },

              routes: [
                GoRoute(
                  path: 'addproducto',
                  builder: (context, state) {
                    return const AddProducto();
                  },
                ),
                GoRoute(
                  path: 'updateProducto/:id', //ruta parametrizada
                  builder: (context, state) {
                    final idProducto = state.pathParameters['id']!; //se obtiene el id de la ruta
                    return  UpdateProducto(
                      id: idProducto,
                    );
                  },
                )
              ]
          ),
          GoRoute(
              path: 'ventas',
              builder: (context, state) {
                return const Ventas();
              },
          ),
          GoRoute(
              path: 'ajustes',
              builder: (context, state) {
                return const Ajustes();
              },
          ),
          GoRoute(
            path: 'reportes',
            builder: (context, state) {
              return const ReporteVentas();
            },
          ),
          GoRoute(
            path: 'clientes',
            builder: (context, state) {
              return Clientes();
            },
          ),
        ],
      ),
    ],
    //Te redirige a una ruta y no te permite salir de ella, a menos que retorne null.
    redirect: (context, state) async {
      final isUserLogeado = await ref.read(loginStateProvider).isUsuarioLogeado();
      if(!isUserLogeado){
        return "/"; //te redirige al login si el usuario no esta logeado
      }
      return null; //si el usuario esta logeado te permite navegar en la app.
    },
  );
 return _router;
},);