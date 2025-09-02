import '../../imports.dart';

class RedefinePassword extends StatefulWidget {
  final Pessoa user;
  const RedefinePassword({required this.user, super.key});

  @override
  State<RedefinePassword> createState() => _RedefinePasswordState();
}

class _RedefinePasswordState extends State<RedefinePassword> {
  Color corPergunta = ColorConst.first;
  String _userSenha = '';
  String _confirmarSenha = '';
  bool isVisible = true;
  final enc = Encriptador();

  void changeVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void onPressed() async {
    if (_userSenha.isEmpty) {
      setState(() {
        corPergunta = Colors.red;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, digite uma senha')),
      );
    } else if (_userSenha.length < 5) {
      setState(() {
        corPergunta = Colors.red;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, digite uma senha valida')),
      );
    } else if (_userSenha != _confirmarSenha) {
      setState(() {
        corPergunta = Colors.red;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não coincidem')),
      );
    } else{
      if(await PessoaService.redefinePassword(enc.encriptar(_userSenha), widget.user.id)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(user: widget.user)
          )
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao redefinir senha')),
        );
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                top: cellHeight * 40,
                width: cellWidth * 29,
                height: cellHeight * 8,
                child: Center(
                  child: CaixaPergunta(
                    key: ValueKey(corPergunta),
                    cor: corPergunta,
                    onValueChanged: (valor) {
                      setState(() {
                        _userSenha = valor;
                      });
                    },
                    labelText: 'Nova senha:',
                    obscureText: false,
                    formatador: false,
                  ),
                ),
              ),

              Positioned(
                left: cellWidth * 8,
                top: cellHeight * 52,
                width: cellWidth * 29,
                height: cellHeight * 8,
                child: Center(
                  child: CaixaPergunta(
                    key: ValueKey(corPergunta),
                    cor: corPergunta,
                    onValueChanged: (valor) {
                      setState(() {
                        _confirmarSenha = valor;
                      });
                    },
                    labelText: 'Nova senha novamente:',
                    obscureText: isVisible,
                    formatador: false,
                  ),
                ),
              ),

              Positioned(
                left: cellWidth * 38,
                top: cellHeight * 55,
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
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: ColorConst.first,
                    size: 30,
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
