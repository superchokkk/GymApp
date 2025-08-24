import 'imports.dart';

class AskCpf extends StatefulWidget {
  const AskCpf({super.key});

  @override
  State<AskCpf> createState() => _AskCpfState();
}

class _AskCpfState extends State<AskCpf> {
  String userCpf = "";
  bool isLoading = false;
  Color corPergunta = ColorConst.first;
  final encriptador = Encriptador();

  void onPressed() async {
    String cpfLimpo = CpfUtils.desformatador(userCpf);
    if (CpfUtils.isValidCpf(userCpf) == false) {
      setState(() {
        corPergunta = Colors.red;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, digite um CPF válido')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      String cpf = encriptador.encriptar(cpfLimpo);
      final cliente = await PessoaService.buscarPessoaPorCpf(cpf);

      if (!mounted) return;

      if (cliente == null) {
        setState(() {
          corPergunta = Colors.red;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Usuário não encontrado')));
        return;
      }
      Pessoa user = cliente;
      if (!mounted) return;
      print(user.senha);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AskSenha(user: user)),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao buscar cliente. Verifique sua conexão.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
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
                        userCpf = valor;
                      });
                    },
                    labelText: 'cpf: 123.456.789-00',
                    formatador: true,
                  ),
                ),
              ),

              Positioned(
                left: cellWidth * 12,
                top: cellHeight * 67,
                width: cellWidth * 21,
                height: cellHeight * 7,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.first,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),

                  child:
                      isLoading
                          ? CircularProgressIndicator(color: ColorConst.third)
                          : Text(
                            "Continuar",
                            style: TextStyle(
                              color: ColorConst.third,
                              fontSize: 20,
                            ),
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
