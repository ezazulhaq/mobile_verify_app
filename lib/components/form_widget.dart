import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobil_verify_app/components/button_widget.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    Key? key,
    required this.controller,
    this.hintText,
    this.buttonLabel,
    this.press,
    required this.state,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? buttonLabel;
  final Function? press;
  final dynamic state;

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
