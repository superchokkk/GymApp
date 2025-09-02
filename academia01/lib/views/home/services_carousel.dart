import 'package:flutter/material.dart';

class ServicesCarousel extends StatelessWidget {
  const ServicesCarousel({Key? key}) : super(key: key);

  final List<ServiceItem> services = const [
    ServiceItem(icon: Icons.train, label: 'Treinos'),
    ServiceItem(icon: Icons.payment, label: 'Pagamento'),
    ServiceItem(icon: Icons.trending_up, label: 'Evolução'),
    ServiceItem(icon: Icons.store, label: 'Loja'),
    ServiceItem(icon: Icons.straighten, label: 'Medidas'),
    ServiceItem(icon: Icons.message, label: 'Mensagens'),
    ServiceItem(icon: Icons.group, label: 'Equipe'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
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
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8BC34A),
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8BC34A).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
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

class ServiceItem {
  final IconData icon;
  final String label;

  const ServiceItem({
    required this.icon,
    required this.label,
  });
}