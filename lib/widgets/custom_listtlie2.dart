import 'package:flutter/material.dart';

class CustomListTile2 extends StatelessWidget {
  const CustomListTile2({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF3A3A3A),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
