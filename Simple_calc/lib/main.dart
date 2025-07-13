import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _input = '0';
  String _result = '';
  String _operation = '';
  double _num1 = 0;
  bool _isNewNumber = true;

  void _onDigitPress(String digit) {
    setState(() {
      if (_isNewNumber) {
        _input = digit;
        _isNewNumber = false;
      } else {
        if (_input == '0') {
          _input = digit;
        } else {
          _input += digit;
        }
      }
    });
  }

  void _onOperationPress(String operation) {
    setState(() {
      _num1 = double.parse(_input);
      _operation = operation;
      _isNewNumber = true;
    });
  }

  void _onEqualsPress() {
    setState(() {
      double num2 = double.parse(_input);
      switch (_operation) {
        case '+':
          _result = (_num1 + num2).toString();
          break;
        case '-':
          _result = (_num1 - num2).toString();
          break;
        case '×':
          _result = (_num1 * num2).toString();
          break;
        case '÷':
          _result = (_num1 / num2).toString();
          break;
      }
      _input = _result;
      _isNewNumber = true;
    });
  }

  void _onClearPress() {
    setState(() {
      _input = '0';
      _result = '';
      _operation = '';
      _num1 = 0;
      _isNewNumber = true;
    });
  }

  Widget _buildButton(String text, {Color? color, VoidCallback? onPressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Theme.of(context).colorScheme.surface,
            foregroundColor: color != null ? Colors.white : Theme.of(context).colorScheme.onSurface,
            padding: const EdgeInsets.all(24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _result,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _input,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton('C', color: Colors.red.shade300, onPressed: _onClearPress),
                      _buildButton('±', onPressed: () {}),
                      _buildButton('%', onPressed: () {}),
                      _buildButton('÷', color: Colors.blue.shade300, onPressed: () => _onOperationPress('÷')),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('7', onPressed: () => _onDigitPress('7')),
                      _buildButton('8', onPressed: () => _onDigitPress('8')),
                      _buildButton('9', onPressed: () => _onDigitPress('9')),
                      _buildButton('×', color: Colors.blue.shade300, onPressed: () => _onOperationPress('×')),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('4', onPressed: () => _onDigitPress('4')),
                      _buildButton('5', onPressed: () => _onDigitPress('5')),
                      _buildButton('6', onPressed: () => _onDigitPress('6')),
                      _buildButton('-', color: Colors.blue.shade300, onPressed: () => _onOperationPress('-')),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('1', onPressed: () => _onDigitPress('1')),
                      _buildButton('2', onPressed: () => _onDigitPress('2')),
                      _buildButton('3', onPressed: () => _onDigitPress('3')),
                      _buildButton('+', color: Colors.blue.shade300, onPressed: () => _onOperationPress('+')),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('0', onPressed: () => _onDigitPress('0')),
                      _buildButton('.', onPressed: () => _onDigitPress('.')),
                      _buildButton('=', color: Colors.blue.shade500, onPressed: _onEqualsPress),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
