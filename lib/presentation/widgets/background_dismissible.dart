import 'package:flutter/material.dart';

class BackgroundDismissible extends StatelessWidget {
  const BackgroundDismissible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(Icons.delete),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
