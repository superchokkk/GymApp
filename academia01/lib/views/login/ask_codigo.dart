import 'imports.dart';

class AskCodigo extends StatefulWidget {
  final Pessoa user;
  final String codigo;
  const AskCodigo({required this.user, required this.codigo, super.key});

  @override
  State<AskCodigo> createState() => _AskCodigoState();
}

class _AskCodigoState extends State<AskCodigo> {
  String codigoDigitado = "";
  Color corPergunta = ColorConst.first;

  void validarCodigo() {
    if (codigoDigitado == widget.codigo) {
      // Código correto, pode redirecionar para redefinir senha ou home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(user: widget.user)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código incorreto')),
      );
      setState(() {
        corPergunta = Colors.red;
      });
    }
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
                top: cellHeight * 47,
                width: cellWidth * 29,
                height: cellHeight * 8,
                child: Center(
                  child: CaixaPergunta(
                    key: ValueKey(corPergunta),
                    cor: corPergunta,
                    onValueChanged: (valor) {
                      setState(() {
                        codigoDigitado = valor;
                      });
                    },
                    labelText: 'Digite o código recebido:',
                    obscureText: false,
                  ),
                ),
              ),
              Positioned(
                left: cellWidth * 12,
                top: cellHeight * 67,
                width: cellWidth * 21,
                height: cellHeight * 7,
                child: ElevatedButton(
                  onPressed: validarCodigo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.first,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Validar",
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
