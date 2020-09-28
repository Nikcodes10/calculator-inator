import 'dart:math';

class DisplayService {
  int _factorial(int n) {
    if (n > 20) throw FormatException('Cannot calculate factorial > 20');
    int f = 1;
    for (int i = 2; i <= n; i++) {
      f = f * i;
    }
    return n >= 0
        ? f
        : throw FormatException('Cannot calculate negative number factorial');
  }

  int _combinator(int n, int r) {
    if (n < r) {
      throw FormatException("n should be >= r");
    }
    return _factorial(n) ~/ (_factorial(r) * _factorial(n - r));
  }

  int _permutator(int n, int r) {
    if (n < r) {
      throw FormatException("n should be >= r");
    }
    return _factorial(n) ~/ _factorial(n - r);
  }

  double _calculator(List numb) {
    int index;
    const List operators = [
      'p',
      'c',
      'root',
      '^',
      'sq',
      'x3',
      'sin',
      'cos',
      'tan',
      'cot',
      'cosec',
      'sec',
      'ln',
      'e',
      '!',
      '/',
      '*',
      '+',
      '-',
    ];
    for (int i = 0; i < operators.length; i++) {
      while (numb.indexOf(operators[i]) >= 0) {
        index = numb.indexOf(operators[i]);
        int f = 0;
        String op = operators[i];
        if (op == '/') {
          numb[index + 1] = numb[index - 1] / numb[index + 1];
        } else if (op == '*') {
          numb[index + 1] = numb[index - 1] * numb[index + 1];
        } else if (op == '+') {
          numb[index + 1] = numb[index - 1] + numb[index + 1];
        } else if (op == '-') {
          numb[index + 1] = numb[index - 1] - numb[index + 1];
        } else if (op == '!') {
          numb[index] =
              _factorial(int.parse(numb[index - 1].toString().split('.')[0]));
          f++;
        } else if (op == 'sin') {
          numb[index + 1] = sin(numb[index + 1]);
          index++;
          f++;
        } else if (op == 'cos') {
          numb[index + 1] = cos(numb[index + 1]);
          index++;
          f++;
        } else if (op == 'tan') {
          numb[index + 1] = tan(numb[index + 1]);
          index++;
          f++;
        } else if (op == 'cot') {
          numb[index + 1] = 1 / tan(numb[index + 1]);
          index++;
          f++;
        } else if (op == 'cosec') {
          numb[index + 1] = 1 / sin(numb[index + 1]);
          index++;
          f++;
        } else if (op == 'sec') {
          numb[index + 1] = 1 / cos(numb[index + 1]);
          index++;
          f++;
        } else if (op == 'ln') {
          numb[index + 1] = log(numb[index + 1]);
          index++;
          f++;
        } else if (op == 'e') {
          numb[index + 1] = exp(numb[index + 1]);
          index++;
          f++;
        } else if (op == 'root') {
          numb[index + 1] = sqrt(numb[index + 1]);
          index++;
          f++;
        } else if (op == '^') {
          numb[index + 1] = pow(numb[index - 1], numb[index + 1]);
        } else if (op == 'sq') {
          numb[index + 1] = pow(numb[index + 1], 2);
          f++;
          index++;
        } else if (op == 'x3') {
          numb[index] = pow(numb[index - 1], 2);
          f++;
        } else if (op == 'p') {
          numb[index] = _permutator(
                  numb[index - 1].truncate(), numb[index + 1].truncate())
              .toDouble();
          numb[index - 1] = null;
          numb.removeWhere((element) => element == null);
          index++;
          f++;
        } else if (op == 'c') {
          numb[index] = _combinator(
                  numb[index - 1].truncate(), numb[index + 1].truncate())
              .toDouble();
          numb[index - 1] = null;
          numb.removeWhere((element) => element == null);
          index++;
          f++;
        }

        if (f == 0) {
          numb[index] = null;
        }
        numb[index - 1] = null;
        numb.removeWhere((element) => element == null);
      }
    }
    if (numb.length != 1) {
      throw FormatException("Syntax Error");
    }
    return numb[0] + 0.0;
  }

  double brackets(List s) {
    int i = 0, end = -1;
    List starters = [];
    double tans;
    List x = [];
    s.insert(0, '(');
    s.add(')');
    while (true) {
      if (s.length == 1) {
        break;
      }
      if (s[i] == ')') {
        if (starters.length == 0) {
          throw FormatException("Syntax Error");
        }
        tans = _calculator(x);

        end = i;
        s[end] = tans;
        for (int j = starters.removeLast(); j < end; j++) {
          s[j] = null;
        }

        s.removeWhere((element) => element == null);
        if (starters.length != 0) {
          i = starters.removeLast() - 1;
        } else {
          i = -1;
        }
      } else if (s[i] == '(') {
        x.clear();
        starters.add(i);
      } else {
        x.add(s[i]);
      }
      i++;
    }
    if (s.length != 1) {
      throw FormatException("Syntax Error");
    }
    return double.parse((s[0] + 0.0).toStringAsFixed(6));
  }

  List generator(List exp, List numbers) {
    String cache = "";
    List finalExp = [];
    for (String item in exp) {
      bool digit = false;
      if (item == 'x')
        item = '*';
      else if (item == '√') {
        item = 'root';
        try {
          if (finalExp.last == ')') {
            finalExp.add('*');
          }
        } catch (e) {}
      } else if (item == 'pi') {
        item = '0';
        cache = pi.toString();
      } else if (item == 'e') {
        item = '0';
        cache = e.toString();
      }
      if (item == '.') {
        digit = true;
        cache = cache + item;
      }
      if (!digit) {
        for (String number in numbers) {
          if (item == number) {
            cache = cache + item;
            digit = true;
            break;
          }
        }
      }
      if (!digit) {
        if (cache.isNotEmpty) {
          finalExp.add(double.parse(cache));
          if (item == 'root') {
            finalExp.add('*');
          }
        }
        finalExp.add(item);
        cache = "";
      }
    }
    if (cache != "") finalExp.add(double.parse(cache));
    while (true) {
      int i = finalExp.indexOf('-');
      if (i == -1) break;
      bool b = false;
      if (i > 0) {
        if (finalExp[i - 1] is double || finalExp[i - 1].toString() == ')') {
          finalExp[i] = '+';
          b = true;
          i++;
        }
      }
      if (!b) {
        finalExp.removeAt(i);
      }
      while (i < finalExp.length) {
        if (finalExp[i].toString() != '(') break;
        i++;
      }
      finalExp[i] = -1 * finalExp[i];
    }
    return finalExp;
  }
}
