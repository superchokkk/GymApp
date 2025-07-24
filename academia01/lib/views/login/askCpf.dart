import 'package:flutter/material.dart';
import '../../commons/imports.dart';
import '../../features/pessoas/alunos/services/alunoService.dart';

class askCpf extends StatefulWidget {
  const askCpf({super.key});

  @override
  State<askCpf> createState() => _askCpfState();
}

class _askCpfState extends State<askCpf> {
  String userCpf = "";
  bool isLoading = false;

  void onPressed() async {
    if (userCpf.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, digite um CPF válido')),
      );
      return;
    }

    // Remove formatação do CPF (pontos, hífens, etc.)
    String cpfLimpo = userCpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (cpfLimpo.length != 11) {
      throw ArgumentError('CPF deve conter 11 dígitos');
    }

    setState(() {
      isLoading = true;
    });

    try {
      final aluno = await AlunoService.buscarAlunoPorCpf(cpfLimpo);

      if (aluno != null) {
        print('Nome do aluno encontrado: ${aluno.nivel}');

        // Mostrar mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Aluno encontrado: ${aluno.nome}')),
        );
      } else {
        print('Aluno não encontrado para o CPF: $userCpf');

        // Mostrar mensagem de erro
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Aluno não encontrado')));
      }
    } catch (e) {
      print('Erro ao buscar aluno: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao buscar aluno. Verifique sua conexão.'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    //fazendo a tela de matriz 20x12
    double cellWidth = screenWidth / 12;
    double cellHeight = screenHeight / 20;

    Color corPergunta = colorConst.first;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: colorConst.second,
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
                    images.logo,
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
                  child: caixaPergunta(
                    key: ValueKey(corPergunta),
                    cor: corPergunta,
                    onValueChanged: (valor) {
                      setState(() {
                        userCpf = valor;
                        print(userCpf);
                      });
                    },
                    labelText: 'cpf',
                    validador: cpfUtils.isValidCpf,
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
                    backgroundColor: colorConst.first,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child:
                      isLoading
                          ? CircularProgressIndicator(color: colorConst.third)
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fitness_center,
                                color: colorConst.third,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Continuar",
                                style: TextStyle(color: colorConst.third),
                              ),
                              Icon(
                                Icons.fitness_center,
                                color: colorConst.third,
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
