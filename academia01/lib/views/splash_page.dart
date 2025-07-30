import '../commons/imports.dart';
import 'login/ask_cpf.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AskCpf(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConst.second, 
      child: Center(
        child: Image(image: AssetImage(Images.logo), width: 200, height: 200),
      )
    );
  }
}
