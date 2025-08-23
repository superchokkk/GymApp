import 'package:flutter/material.dart';

class CaixaPergunta extends StatefulWidget {
  final Color cor;
  final void Function(String) onValueChanged;
  final String labelText;
  final bool obscureText;
  final bool formatador;

  const CaixaPergunta({
    super.key,
    required this.cor,
    required this.onValueChanged,
    required this.labelText,
    this.obscureText = false,
    this.formatador = false,
  });

  @override
  State<CaixaPergunta> createState() => _CaixaPerguntaState();
}

class _CaixaPerguntaState extends State<CaixaPergunta> {
  String resposta = "";
  late Color corAtual;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    corAtual = widget.cor;
    _controller = TextEditingController();
  }

  @override
  void didUpdateWidget(CaixaPergunta oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cor != widget.cor) {
      setState(() {
        corAtual = widget.cor;
      });
    }
  }

  String formatCpf(String value) {
    var digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 11) digits = digits.substring(0, 11);
    var formatted = '';
    for (int i = 0; i < digits.length; i++) {
      formatted += digits[i];
      if (i == 2 || i == 5) formatted += '.';
      if (i == 8) formatted += '-';
    }
    return formatted;
  }

  int _calculateCursorPosition(String oldText, String newText, int oldCursorPosition) {
    String digitsBeforeCursor = oldText.substring(0, oldCursorPosition).replaceAll(RegExp(r'\D'), '');
    int digitCount = digitsBeforeCursor.length;
    int newPosition = 0;
    int digitsFound = 0;
    
    for (int i = 0; i < newText.length && digitsFound < digitCount; i++) {
      if (RegExp(r'\d').hasMatch(newText[i])) {
        digitsFound++;
      }
      newPosition = i + 1;
    }
    
    return newPosition.clamp(0, newText.length);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: corAtual.withOpacity(0.6)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: corAtual, width: 2.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: corAtual.withOpacity(1), width: 2.0),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: corAtual.withOpacity(0.6)),
        ),
      ),
      style: TextStyle(color: corAtual.withOpacity(0.8)),
      cursorColor: corAtual,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        String result = value;
        if (widget.formatador) {
          String oldText = _controller.text;
          int oldCursorPosition = _controller.selection.baseOffset;
          
          String formatted = formatCpf(value);
          
          if (formatted != value) {
            int newCursorPosition = _calculateCursorPosition(oldText, formatted, oldCursorPosition);
            _controller.value = TextEditingValue(
              text: formatted,
              selection: TextSelection.collapsed(offset: newCursorPosition),
            );
          }
          result = formatted;
        }
        setState(() {
          resposta = result;
          widget.onValueChanged(result);
        });
      },
    );
  }
}