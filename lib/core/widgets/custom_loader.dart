import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
            color: Color.fromARGB(255, 52, 140, 54),
            strokeWidth: 6,
          );
  }
}