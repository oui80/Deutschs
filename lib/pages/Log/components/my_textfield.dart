import 'package:Dutch/Widgets/neurimrophic.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../main.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
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
          validator: (email) =>
          email != null && !EmailValidator.validate(email)
              ? 'Enter a valid email' : null,
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