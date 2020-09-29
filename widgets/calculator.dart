import 'package:calculator_inator/services/displayService.dart';
import 'package:calculator_inator/shared/constants.dart';
import 'package:calculator_inator/widgets/ansbtn.dart';
import 'package:calculator_inator/widgets/display.dart';
import 'package:calculator_inator/widgets/tile.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  final ds = DisplayService();
  final c = Constants();
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List exp = ['_'];
  bool show = false;
  String x = '_';
  int pos = 0;
  double ans = 0;
  void entry(val) {
    if (val == 'C') {
      if (pos > 0) {
        setState(() {
          exp.removeAt(exp.indexOf('_') - 1);
          x = exp.join();
          pos = pos - 1;
        });
      }
    } else if (val == '=') {
      int index = exp.indexOf('_');
      exp.removeAt(index);
      setState(() {
        try {
          ans = widget.ds.brackets(widget.ds.generator(exp, widget.c.numbers));
        } on ErrorHandler catch (e) {
          x = e.err();
        } catch (e) {
          x = "Syntax Error";
        }
      });
      exp.insert(index, '_');
    } else {
      setState(() {
        exp.insert(pos, val);
        x = exp.join();
        pos = pos + 1;
      });
      for (String operator in widget.c.others) {
        if (val == operator) {
          show = !show;
          if (val != 'pi' && val != 'e') {
            setState(() {
              exp.insert(pos, '(');
              pos = pos + 1;
              exp.insert(pos + 1, ')');
              x = exp.join();
            });
          }
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Display(x),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_left),
                  color: Colors.amberAccent,
                  iconSize: 50,
                  onPressed: () {
                    int index = exp.indexOf('_');
                    if (index > 0) {
                      pos = pos - 1;
                      exp.removeAt(index);
                      exp.insert(index - 1, '_');
                      setState(() {
                        x = exp.join();
                      });
                    }
                  }),
              Answer(ans, entry),
              IconButton(
                  icon: Icon(Icons.arrow_right),
                  color: Colors.amberAccent,
                  iconSize: 50,
                  onPressed: () {
                    int index = exp.indexOf('_');
                    if (index < exp.length - 1) {
                      pos = pos + 1;
                      exp.removeAt(index);
                      exp.insert(index + 1, '_');
                      setState(() {
                        x = exp.join();
                      });
                    }
                  }),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Wrap(
            direction: Axis.horizontal,
            children: List.generate(20, (index) {
              return Tiles(index, entry, show);
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  x = '_';
                  exp = ['_'];
                  pos = 0;
                });
              },
              child: Container(
                padding: EdgeInsets.all(2),
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 27,
                    child: Text(
                      "AC",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 27,
              child: IconButton(
                icon: Icon(Icons.swap_horiz),
                color: Colors.amber,
                iconSize: 40,
                onPressed: () {
                  setState(() {
                    show = !show;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
