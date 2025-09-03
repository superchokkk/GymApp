import '../../imports.dart';

class ServiceItem {
  final IconData icon;
  final String label;
  final void Function() onPressed;

  const ServiceItem({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
}
