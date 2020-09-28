import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final expression;
  Display(this.expression);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          expression,
          textAlign: TextAlign.right,
          style: TextStyle(
            height: 1,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 33,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
