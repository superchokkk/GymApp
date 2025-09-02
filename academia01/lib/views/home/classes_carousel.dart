import 'package:flutter/material.dart';

class ClassesCarousel extends StatefulWidget {
  const ClassesCarousel({Key? key}) : super(key: key);

  @override
  State<ClassesCarousel> createState() => _ClassesCarouselState();
}

class _ClassesCarouselState extends State<ClassesCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int currentPage = 0;

  final List<ClassItem> classes = const [
    ClassItem(
      title: 'Natação',
      image: 'assets/natacao.jpg', // Substitua pelo caminho da sua imagem
      gradient: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
    ),
    ClassItem(
      title: 'Sipalki do',
      image: 'assets/sipalki.jpg', // Substitua pelo caminho da sua imagem
      gradient: [Color(0xFF616161), Color(0xFF424242)],
    ),
    ClassItem(
      title: 'Jump',
      image: 'assets/jump.jpg', // Substitua pelo caminho da sua imagem
      gradient: [Color(0xFFFF8A65), Color(0xFFFF7043)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Carrossel
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: classes.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(
                  horizontal: currentPage == index ? 5 : 15,
                  vertical: currentPage == index ? 0 : 20,
                ),
                child: _buildClassCard(classes[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        
        // Indicadores de página
        _buildPageIndicators(),
      ],
    );
  }

  Widget _buildClassCard(ClassItem classItem) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: classItem.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: classItem.gradient.first.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Imagem de fundo
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(classItem.image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          
          // Overlay com gradiente
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          
          // Título da aula
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Text(
              classItem.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        classes.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index 
                ? const Color(0xFF8BC34A) 
                : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class ClassItem {
  final String title;
  final String image;
  final List<Color> gradient;

  const ClassItem({
    required this.title,
    required this.image,
    required this.gradient,
  });
}