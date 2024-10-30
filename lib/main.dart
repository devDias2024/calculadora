import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String output = "0";  // Resultado exibido
  String operador = "";  // Operador atual
  double num1 = 0;       // Primeiro número
  double num2 = 0;       // Segundo número

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0";  // Limpar a saída
        num1 = 0;
        num2 = 0;
        operador = "";
      } else if (buttonText == "=") {
        num2 = double.parse(output);  // Captura o segundo número
        // Realiza a operação
        switch (operador) {
          case "+":
            output = (num1 + num2).toString();
            break;
          case "-":
            output = (num1 - num2).toString();
            break;
          case "*":
            output = (num1 * num2).toString();
            break;
          case "/":
            output = (num1 / num2).toString();
            break;
        }
        // Reseta para o próximo cálculo
        num1 = double.parse(output);
        operador = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
        num1 = double.parse(output);  // Captura o primeiro número
        operador = buttonText;  // Armazena o operador
        output = "0";  // Limpa a saída para o próximo número
      } else {
        // Atualiza a saída com o número pressionado
        if (output == "0") {
          output = buttonText;  // Se a saída for zero, substitui
        } else {
          output += buttonText;  // Adiciona o número à saída
        }
      }
    });
  }

  Widget buildButton(String buttonText, Color color, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0), // Adiciona espaço entre os botões
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Bordas arredondadas
            ),
            padding: EdgeInsets.symmetric(vertical: 20), // Espaçamento vertical
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24, color: textColor), // Cor do texto
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                output,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          // A primeira linha de botões
          Row(
            children: <Widget>[
              buildButton("7", Colors.grey[300]!, Colors.black),
              buildButton("8", Colors.grey[300]!, Colors.black),
              buildButton("9", Colors.grey[300]!, Colors.black),
              buildButton("/", Colors.orange, Colors.white),
            ],
          ),
          // A segunda linha de botões
          Row(
            children: <Widget>[
              buildButton("4", Colors.grey[300]!, Colors.black),
              buildButton("5", Colors.grey[300]!, Colors.black),
              buildButton("6", Colors.grey[300]!, Colors.black),
              buildButton("*", Colors.orange, Colors.white),
            ],
          ),
          // A terceira linha de botões
          Row(
            children: <Widget>[
              buildButton("1", Colors.grey[300]!, Colors.black),
              buildButton("2", Colors.grey[300]!, Colors.black),
              buildButton("3", Colors.grey[300]!, Colors.black),
              buildButton("-", Colors.orange, Colors.white),
            ],
          ),
          // A quarta linha de botões
          Row(
            children: <Widget>[
              buildButton("C", Colors.red, Colors.white),
              buildButton("0", Colors.grey[300]!, Colors.black),
              buildButton("=", Colors.green, Colors.white),
              buildButton("+", Colors.orange, Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
