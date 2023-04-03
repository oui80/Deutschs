import 'package:Dutch/Widgets/neurimrophic.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0,right: 18),
      child: GestureDetector(
        onTap: onTap,
        child: myContainer(
          Container(
            padding: const EdgeInsets.all(25),
            //margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    tan2,
                    tan1,
                  ],
                )),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}