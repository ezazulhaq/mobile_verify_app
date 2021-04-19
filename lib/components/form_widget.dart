import 'package:flutter/material.dart';
import 'package:mobil_verify_app/components/button_widget.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    Key? key,
    required this.controller,
    this.hintText,
    this.buttonLabel,
    required this.press,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? buttonLabel;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: () {},
          child: ButtonWidget(
            buttonLabel: buttonLabel,
          ),
        ),
        Spacer(),
      ],
    );
  }
}
