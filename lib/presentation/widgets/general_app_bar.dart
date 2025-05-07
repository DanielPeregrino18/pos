import 'package:flutter/material.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeneralAppBar({super.key, required this.theme, required this.title});

  final ColorScheme theme;

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
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
