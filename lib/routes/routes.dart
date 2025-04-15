import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:pos/presentation/pages/add_producto.dart';
import 'package:pos/presentation/pages/ajustes.dart';
import 'package:pos/presentation/pages/login.dart';
import 'package:pos/presentation/pages/productos.dart';
import 'package:pos/presentation/pages/update_producto.dart';
import 'package:pos/presentation/pages/ventas.dart';

import '../presentation/pages/p_o_s.dart';

final GoRouter router = GoRouter(
  routerNeglect: true,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Login();
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
                path: 'updateProducto/:id',
                builder: (context, state) {
                  final idProducto = state.pathParameters['id']!;
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
      ],
    ),
  ],
);