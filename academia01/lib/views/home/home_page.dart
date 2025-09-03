import '../../imports.dart';
import 'export.dart';

class MainScreen extends StatefulWidget {
  final Pessoa user;
  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Pessoa user;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    user = widget.user;
    return Scaffold(
      backgroundColor: ColorConst.second,
      body: SafeArea(
        child: Column(
          children: [
            BannerClass(name: user.nome, height: height, width: width),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.1),
                  ServicesCarousel(height: height, width: width),
                  const SizedBox(height: 30),
                  Text(
                    'Agende sua aula',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
