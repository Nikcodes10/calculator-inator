import 'package:calculator_inator/ui/colors.dart';
import 'package:calculator_inator/widgets/calculator.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        color: Coloring().homebg,
        child: Calculator(),
      ),
    );
  }
}
