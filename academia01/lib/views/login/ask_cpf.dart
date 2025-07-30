import 'imports.dart';

class AskCpf extends StatefulWidget {
  const AskCpf({super.key});

  @override
  State<AskCpf> createState() => _AskCpfState();
}

class _AskCpfState extends State<AskCpf> {
  String userCpf = "";
  bool isLoading = false;

  void onPressed() async {
    if (userCpf.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, digite um CPF válido')),
      );
      return;
    }
    String cpfLimpo = userCpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (cpfLimpo.length != 11) {
      throw ArgumentError('CPF deve conter 11 dígitos');
    }

    setState(() {
      isLoading = true;
    });

    try {
      final cliente = await PessoaService.buscarPessoaPorCpf(cpfLimpo);

      if (!mounted) return;

      if (cliente == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário não encontrado')),
        );
        return;
      }

      // Instancia o objeto específico baseado no nível
      late Pessoa user;
      
      if (cliente.nivel == NivelUsuario.admin) {
        user = Pessoa(
          id: cliente.id,
          nome: cliente.nome,
          idade: cliente.idade,
          email: cliente.email,
          cpf: cliente.cpf,
          senha: cliente.senha,
          nivel: cliente.nivel,
        );
      } else if (cliente.nivel == NivelUsuario.professor) {
        user = Funcionario(
          id: cliente.id,
          nome: cliente.nome,
          idade: cliente.idade,
          email: cliente.email,
          cpf: cliente.cpf,
          senha: cliente.senha,
          nivel: cliente.nivel,
          idFuncao: cliente.idFuncao,
          salario: cliente.salario,
        );
      } else {
          user = Aluno(
            id: cliente.id,
            nome: cliente.nome,
            idade: cliente.idade,
            email: cliente.email,
            cpf: cliente.cpf,
            senha: cliente.senha,
            nivel: cliente.nivel,
            idAcademia: cliente.idAcademia,
          );
        }
      

      // Agora user contém a instância específica do tipo correto
      print('Usuário instanciado: ${user.runtimeType} - ${user.nome}');
      
      if (!mounted) return;
      
      //mudar tela (senha, levando o user)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AskSenha(),
        ),
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
    double cellWidth = screenWidth / 12;
    double cellHeight = screenHeight / 20;

    Color corPergunta = ColorConst.first;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ColorConst.second,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: cellWidth * 4,
                top: cellHeight * 3,
                width: cellWidth * 4,
                height: cellHeight * 4,
                child: Center(
                  child: Image.asset(
                    Images.logo,
                    width: cellWidth * 4,
                    height: cellHeight * 4,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Positioned(
                left: cellWidth * 2,
                top: cellHeight * 12,
                width: cellWidth * 8,
                height: cellHeight * 2,
                child: Center(
                  child: CaixaPergunta(
                    key: ValueKey(corPergunta),
                    cor: corPergunta,
                    onValueChanged: (valor) {
                      setState(() {
                        userCpf = valor;
                        print(userCpf);
                      });
                    },
                    labelText: 'cpf',
                    validador: CpfUtils.isValidCpf,
                  ),
                ),
              ),

              Positioned(
                left: cellWidth * 4,
                top: cellHeight * 15,
                width: cellWidth * 4,
                height: cellHeight * 2,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.first,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child:
                      isLoading
                          ? CircularProgressIndicator(color: ColorConst.third)
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fitness_center,
                                color: ColorConst.third,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Continuar",
                                style: TextStyle(color: ColorConst.third),
                              ),
                              Icon(
                                Icons.fitness_center,
                                color: ColorConst.third,
                              ),
                            ],
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
