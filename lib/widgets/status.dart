import 'package:flutter/material.dart';

class Statuses extends StatelessWidget {
  Statuses(
      {super.key,
      required this.data,
      required this.name,
      required this.icons,
      required this.color});

  String name;
  String data;
  IconData icons;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
        ),
        Text(
          name,
          style: TextStyle(
            color: Colors.white.withOpacity(.9),
            fontSize: 17,
          ),
        ),
        SizedBox(
          width: 180,
        ),
        Text(
          data,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          icons,
          color: color,
        ),
      ],
    );
  }
}
