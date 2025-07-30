import 'package:flutter/material.dart';

class CaixaPergunta extends StatefulWidget {
  final Color cor;
  final void Function(String) onValueChanged;
  final String labelText;
  final bool Function(String) validador;

  const CaixaPergunta({
    super.key,
    required this.cor,
    required this.onValueChanged,
    required this.labelText,
    required this.validador,
  });

  @override
  State<CaixaPergunta> createState() => _CaixaPerguntaState();
}

class _CaixaPerguntaState extends State<CaixaPergunta> {
  String resposta = "";
  late Color corAtual;

  @override
  void initState() {
    super.initState();
    corAtual = widget.cor;
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

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: corAtual),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: corAtual, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: corAtual, width: 1.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: corAtual),
        ),
      ),
      style: TextStyle(color: corAtual),
      cursorColor: corAtual,
      onChanged: (value) {
        setState(() {
          resposta = value;//recebe uma classe e usa a classe recebida mandando a resposta para o validamento
          widget.onValueChanged(value);
        });
      },
    );
  }
}