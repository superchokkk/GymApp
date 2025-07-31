import 'package:academia01/commons/imports.dart';
import '../../features/pessoas/model/pessoa.dart';

class HomePage extends StatefulWidget{
  final Pessoa user;
  const HomePage({required this.user, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, ${widget.user.nome}'),
      ),
      body: Center(
        child: Text('Página inicial do usuário ${widget.user.nome}'),
      ),
    );
  }
}