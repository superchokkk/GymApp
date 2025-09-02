import 'services_carousel.dart';
import 'classes_carousel.dart';
import '../../imports.dart';

class MainScreen extends StatelessWidget {
  final Pessoa user;
  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    return Scaffold(  
      backgroundColor: ColorConst.second,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner com textos sobrepostos
              _buildBanner(largura, altura, user),
              // Conteúdo com padding
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    // Carrossel de serviços
                    const ServicesCarousel(),
                    const SizedBox(height: 30),
                    // Título "Agende sua aula"
                    const Text(
                      'Agende sua aula',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Carrossel de aulas
                    const ClassesCarousel(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Banner isolado
  Widget _buildBanner(largura, altura, Pessoa user) {
    return Container(
      width: largura * 1.2,
      height: altura * 0.33,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(Images.banner),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem vindo',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black45,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                Text(
                  user.nome,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black45,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Saudação e notificações (removido, agora no banner)
}