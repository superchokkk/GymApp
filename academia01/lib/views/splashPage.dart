import '../commons/imports.dart';
import 'login/askCpf.dart';

class splashpage extends StatefulWidget {
  const splashpage({super.key});
  @override
  State<splashpage> createState() => _splashpageState();
}

class _splashpageState extends State<splashpage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const askCpf(),
        ),
      );
    });
    return Container(
      color: colorConst.second, 
      child: Center(
        child: Image(image: AssetImage(images.logo), width: 200, height: 200),
      )
    );
  }
}
