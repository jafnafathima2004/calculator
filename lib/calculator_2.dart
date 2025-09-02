import 'package:flutter/material.dart';

Widget calcButton(
  double height,
  double width,
  Color containerColor,
  String text,
  Color textColor,
  double radius,
  AlignmentGeometry align,
  void Function() onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        alignment: align,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: containerColor,
        ),
        height: height,
        width: width,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

class CalculatorTwo extends StatefulWidget {
  const CalculatorTwo({super.key});

  @override
  State<CalculatorTwo> createState() => _CalculatorTwoState();
}

class _CalculatorTwoState extends State<CalculatorTwo> {
  String output = '0'; // shows current typing or result
  String input = ''; // shows full expression
  double num1 = 0;
  double num2 = 0;
  String operand = '';
  bool newInput = true;

  // Helper: format numbers (remove .0 if integer)
  String format(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    } else {
      return value.toString();
    }
  }

  void buttonPressed(String btnText) {
    setState(() {
      if (btnText == 'AC') {
        output = '0';
        input = '';
        num1 = 0;
        num2 = 0;
        operand = '';
        newInput = true;
      } else if (btnText == '+' ||
          btnText == '-' ||
          btnText == 'x' ||
          btnText == '/') {
        // store first number and operator
        num1 = double.tryParse(output) ?? 0;
        operand = btnText;
        input = "${format(num1)} $operand ";
        newInput = true;
      } else if (btnText == '=') {
        // finalize result
        if (operand.isNotEmpty) {
          num2 = double.tryParse(output) ?? 0;
          double result = 0;
          if (operand == '+') result = num1 + num2;
          if (operand == '-') result = num1 - num2;
          if (operand == 'x') result = num1 * num2;
          if (operand == '/') {
            if (num2 == 0) {
              output = "Error";
              input = '';
              operand = '';
              return;
            }
            result = num1 / num2;
          }
          output = format(result);
          input = "${format(num1)} $operand ${format(num2)} = $output";
          num1 = result;
          num2 = 0;
          operand = '';
          newInput = true;
        }
      } else if (btnText == '×') {
        // backspace
        if (output.isNotEmpty && output != '0') {
          output = output.substring(0, output.length - 1);
          if (output.isEmpty) {
            output = '0';
          }
        }
      } else if (btnText == '%') {
        double temp = double.tryParse(output) ?? 0;
        output = format(temp / 100);
        input = output;
      } else if (btnText == '.') {
        if (!output.contains('.')) {
          output += '.';
        }
        if (newInput) {
          output = "0.";
          newInput = false;
        }
      } else {
        // numbers
        if (newInput || output == '0') {
          output = btnText;
          if (input.isNotEmpty &&
              "+-x/".contains(input.trim().split(" ").last)) {
            input += btnText;
          } else {
            input = btnText;
          }
          newInput = false;
        } else {
          output += btnText;
          input += btnText;
        }

        // 🔥 Live calculation (preview only)
        if (operand.isNotEmpty) {
          num2 = double.tryParse(output) ?? 0;
          double result = 0;
          if (operand == '+') result = num1 + num2;
          if (operand == '-') result = num1 - num2;
          if (operand == 'x') result = num1 * num2;
          if (operand == '/') {
            if (num2 == 0) return;
            result = num1 / num2;
          }
          // show full expression
          input = "${format(num1)} $operand ${output}";
          // show live result
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    final screenwidth = screensize.width;
    final screenheight = screensize.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.calculate_rounded, color: Colors.amber),
            SizedBox(height:screenheight*0.1),
            // Expression
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                input,
                style: const TextStyle(color: Colors.grey, fontSize: 24),
              ),
            ),
            // Output
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20),
                child: Text(
                  output,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey,
                  "AC",
                  Colors.black,
                  60,
                  Alignment.center,
                  () => buttonPressed('AC'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey,
                  '×',
                  Colors.black,
                  60,
                  Alignment.center,
                  () => buttonPressed('×'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey,
                  "%",
                  Colors.black,
                  60,
                  Alignment.center,
                  () => buttonPressed('%'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.amber,
                  "/",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('/'),
                ),
              ],
            ),
            Row(
              children: [
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey[850]!,
                  "7",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('7'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey[850]!,
                  "8",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('8'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey[850]!,
                  "9",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('9'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.amber,
                  "x",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('x'),
                ),
              ],
            ),
            Row(
              children: [
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey[850]!,
                  "4",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('4'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey[850]!,
                  "5",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('5'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey[850]!,
                  "6",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('6'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.amber,
                  "-",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('-'),
                ),
              ],
            ),
            Row(
              children: [
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey[850]!,
                  "1",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('1'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey[850]!,
                  "2",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('2'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey[850]!,
                  "3",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('3'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.amber,
                  "+",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('+'),
                ),
              ],
            ),
            Row(
              children: [
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.42,
                  Colors.grey[850]!,
                  "0",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('0'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.grey[850]!,
                  ".",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('.'),
                ),
                calcButton(
                  screenheight * 0.1,
                  screenwidth * 0.2,
                  Colors.amber,
                  "=",
                  Colors.white,
                  60,
                  Alignment.center,
                  () => buttonPressed('='),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
