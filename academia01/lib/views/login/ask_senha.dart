import 'imports.dart';

class AskSenha extends StatefulWidget {
  const AskSenha({super.key});

  @override
  State<AskSenha> createState() => _AskSenhaState();
}

class _AskSenhaState extends State<AskSenha> {
  @override
  Widget build(BuildContext context) {
    // Implement the UI for asking the password here
    return Scaffold(
      appBar: AppBar(title: const Text('Digite sua Senha')),
      body: Center(
        child: Text('Tela de senha'),
      ),
    );
  }
}