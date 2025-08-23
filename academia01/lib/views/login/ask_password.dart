import 'imports.dart';

class AskSenha extends StatefulWidget {
  final Pessoa user;
  const AskSenha({required this.user, super.key});

  @override
  State<AskSenha> createState() => _AskSenhaState();
}

class _AskSenhaState extends State<AskSenha> {
  String userSenha = "";
  Color corPergunta = ColorConst.first;
  bool isVisible = true;

  void backButton() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AskCpf()),
    );
  }

  String? codigoRecuperacao;
  String gerarCodigo() {
    final random = DateTime.now().millisecondsSinceEpoch;
    return (random % 1000000).toString().padLeft(6, '0');
  }

  Future<void> enviarEmail(String email, String codigo) async {
    try {
      bool enviado = await PessoaService.sendEmail(email, codigo);
      if (enviado) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail enviado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Falha ao enviar e-mail.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  void esqueciSenha() async {
    final codigo = gerarCodigo();
    codigoRecuperacao = codigo;
    await enviarEmail(widget.user.email, codigo);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AskCodigo(user: widget.user, codigo: codigo),
      ),
    );
  }

  void changeVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void onPressed() async {
    if (userSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, digite uma senha')),
      );
      setState(() {
        corPergunta = Colors.red;
      });
    } else if (userSenha == widget.user.senha) {
      Pessoa cliente = widget.user;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(user: cliente)),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Senha incorreta')));
      setState(() {
        corPergunta = Colors.red;
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    //fazendo a tela de matriz 20x12
    double cellWidth = screenWidth / 45;
    double cellHeight = screenHeight / 91;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ColorConst.second,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: cellWidth * 5,
                top: cellHeight * 7,
                width: cellWidth * 4,
                height: cellHeight * 4,
                child: ElevatedButton(
                  onPressed: backButton,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.first,
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),

                  child: Icon(Icons.close, color: ColorConst.third, size: 30),
                ),
              ),

              Positioned(
                left: cellWidth * 17,
                top: cellHeight * 17,
                width: cellWidth * 11,
                height: cellHeight * 11,
                child: Center(
                  child: Image.asset(
                    Images.logo,
                    width: cellWidth * 11,
                    height: cellHeight * 11,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Positioned(
                left: cellWidth * 8,
                top: cellHeight * 47,
                width: cellWidth * 29,
                height: cellHeight * 8,
                child: Center(
                  child: CaixaPergunta(
                    key: ValueKey(corPergunta),
                    cor: corPergunta,
                    onValueChanged: (valor) {
                      setState(() {
                        userSenha = valor;
                      });
                    },
                    labelText: 'Senha:',
                    obscureText: !isVisible,
                    formatador: false,
                  ),
                ),
              ),

              Positioned(
                left: cellWidth * 38,
                top: cellHeight * 50,
                width: cellWidth * 3.5,
                height: cellHeight * 2,
                child: ElevatedButton(
                  onPressed: changeVisibility,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(0, 15, 15, 15),
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),
                  child: Icon(
                    isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: ColorConst.first,
                    size: 30,
                  ),
                ),
              ),

              Positioned(
                left: cellWidth * 13,
                top: cellHeight * 57,
                width: cellWidth * 19,
                height: cellHeight * 3,
                child: ElevatedButton(
                  onPressed: esqueciSenha,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.second,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: Text(
                    "Esqueci a senha",
                    style: TextStyle(
                      color: ColorConst.first.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              Positioned(
                left: cellWidth * 12,
                top: cellHeight * 67,
                width: cellWidth * 21,
                height: cellHeight * 7,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.first,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  child: Text(
                    "Continuar",
                    style: TextStyle(color: ColorConst.third, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
