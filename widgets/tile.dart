import 'package:calculator_inator/services/displayService.dart';
import 'package:calculator_inator/shared/constants.dart';
import 'package:calculator_inator/ui/colors.dart';
import 'package:flutter/material.dart';

int deciderint = 0;
int decider2 = 0;

class Tiles extends StatelessWidget {
  final ds = DisplayService();
  final c = Constants();
  final col = Coloring();
  final i;
  final Function _entry;
  final show;
  Tiles(this.i, this._entry, this.show);
  @override
  Widget build(BuildContext context) {
    List things = [];
    if (show)
      things = c.others;
    else
      things = c.numbers;
    dynamic index = i;
    if (deciderint > 9) {
      if (decider2 > 9) {
        decider2 = 0;
        deciderint = 0;
      }
    }
    if (index < 4)
      index = 10 + decider2++;
    else if ((index + 1) % 4 == 0)
      index = 10 + decider2++;
    else if (deciderint > 9)
      index = 10 + decider2++;
    else
      index = deciderint++;
    if (deciderint == 11) {
      index = 9;
      decider2--;
      deciderint++;
    } else if (deciderint == 10) {
      index = 10 + decider2++;
      deciderint++;
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.11,
      child: ButtonTheme(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: index >= 10
                        ? Colors.white
                        : (show ? Colors.yellow[200] : Colors.white),
                    width: 3.5),
                borderRadius: index >= 10
                    ? BorderRadius.only(
                        topLeft: Radius.elliptical(80, 40),
                        topRight: Radius.elliptical(80, 40),
                        bottomLeft: Radius.elliptical(80, 40),
                        bottomRight: Radius.elliptical(80, 40))
                    : BorderRadius.circular(40)),
            color: index >= 10
                ? col.operColor
                : (show ? col.otherOpsColor : col.numColor),
            onPressed: () {
              _entry(index >= 10 ? c.operators[index - 10] : things[index]);
            },
            child: Text(
              index >= 10 ? c.operators[index - 10] : things[index],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: index >= 10 ? col.operTextColor : col.numTextColor,
                  fontSize: 23),
            ),
          ),
        ),
      ),
    );
  }
}
