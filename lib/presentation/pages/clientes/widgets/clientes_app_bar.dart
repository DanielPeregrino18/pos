import 'package:flutter/material.dart';

class ClientesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClientesAppBar({super.key, required this.theme});

  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Clientes",
        style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: theme.onPrimary),
      backgroundColor: theme.primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
