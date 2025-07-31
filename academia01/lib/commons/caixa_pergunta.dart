import 'package:flutter/material.dart';

class CaixaPergunta extends StatefulWidget {
  final Color cor;
  final void Function(String) onValueChanged;
  final String labelText;
  final bool obscureText;

  const CaixaPergunta({
    super.key,
    required this.cor,
    required this.onValueChanged,
    required this.labelText,
    this.obscureText = false,
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
      onChanged: (value) {
        setState(() {
          resposta = value;//recebe uma classe e usa a classe recebida mandando a resposta para o validamento
          widget.onValueChanged(value);
        });
      },
    );
  }
}