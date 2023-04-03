import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Widgets/neurimrophic.dart';
import '../../../main.dart';

class MyTextFieldMDP extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextFieldMDP({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: myContainer(
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[^$]*$'))],
          validator: (value) =>
          value != null && value.length < 6
              ? 'Mot de passe de 6 characters min.' : null,
          decoration: InputDecoration(
              enabledBorder:
              OutlineInputBorder(
                borderSide: BorderSide(
                    color: myWhite),
              ),
              focusedBorder:
              OutlineInputBorder(
                borderSide: BorderSide(
                    color: myWhite),
              ),
              fillColor: myWhite,
              filled: true,
              hintText: hintText,
              hintStyle:
              TextStyle(color: mygrey1)),
        ),
      ),
    );
  }
}