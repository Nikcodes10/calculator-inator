import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final ans;
  final Function entry;
  Answer(this.ans, this.entry);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Align(
        child: GestureDetector(
          onTap: () {
            for (String char in ans.toString().split('')) {
              entry(char);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3),
            constraints: BoxConstraints(minWidth: 80, minHeight: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 3, color: Colors.amber),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                ans.toString().length > 13
                    ? ans.toStringAsExponential(5)
                    : ans.toString()[ans.toString().length - 1] == '0' &&
                            ans.toString()[ans.toString().length - 2] == '.'
                        ? ans.truncate().toString()
                        : ans.toString(),
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
