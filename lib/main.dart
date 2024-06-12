import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onPressed(String text) {
    setState(() {
      if (text == 'C') {
        _expression = '';
        _result = '';
      } else if (text == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression.replaceAll('x', '*'));
          ContextModel cm = ContextModel();
          _result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += text;
      }
    });
  }

  Widget _buildButton(String text, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onPressed(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.lightBlue),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('7', Colors.blue[100]!),
                    _buildButton('8', Colors.blue[100]!),
                    _buildButton('9', Colors.blue[100]!),
                    _buildButton('/', Colors.orange[300]!),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4', Colors.blue[100]!),
                    _buildButton('5', Colors.blue[100]!),
                    _buildButton('6', Colors.blue[100]!),
                    _buildButton('x', Colors.orange[300]!),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1', Colors.blue[100]!),
                    _buildButton('2', Colors.blue[100]!),
                    _buildButton('3', Colors.blue[100]!),
                    _buildButton('-', Colors.orange[300]!),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('C', Colors.red[300]!),
                    _buildButton('0', Colors.blue[100]!),
                    _buildButton('=', Colors.green[300]!),
                    _buildButton('+', Colors.orange[300]!),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
