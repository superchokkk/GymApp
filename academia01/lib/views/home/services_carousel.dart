import '../../imports.dart';
import 'services_item.dart';
import 'slide_buttons_metodes.dart';

class ServicesCarousel extends StatelessWidget {
  final double height;
  final double width;
  const ServicesCarousel({Key? key, required this.height, required this.width}) : super(key: key);

  final List<ServiceItem> services = const [
    ServiceItem(icon: Icons.fitness_center, label: 'Treinos', onPressed: SlideButtonsMethods.navigateToTraining),
    ServiceItem(icon: Icons.payment, label: 'Pagamento', onPressed: SlideButtonsMethods.navigateToPayment),
    ServiceItem(icon: Icons.trending_up, label: 'Evolução', onPressed: SlideButtonsMethods.navigateToProgress),
    ServiceItem(icon: Icons.store, label: 'Loja', onPressed: SlideButtonsMethods.navigateToStore),
    ServiceItem(icon: Icons.straighten, label: 'Medidas', onPressed: SlideButtonsMethods.navigateToMeasurements),
    ServiceItem(icon: Icons.message, label: 'Mensagens', onPressed: SlideButtonsMethods.navigateToMessages),
    ServiceItem(icon: Icons.group, label: 'Equipe', onPressed: SlideButtonsMethods.navigateToTeam),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                // Círculo com ícone
                Container(
                  width: width * 0.18,
                  height: width * 0.18,
                  decoration: BoxDecoration(
                    color: ColorConst.first,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    services[index].icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Label do serviço
                Text(
                  services[index].label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}