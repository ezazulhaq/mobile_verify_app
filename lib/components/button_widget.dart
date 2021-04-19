import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.buttonLabel,
  }) : super(key: key);

  final String? buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      height: 50,
      width: double.infinity,
      child: Center(
        child: Text(
          "$buttonLabel",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
