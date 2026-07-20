import 'package:flutter/material.dart';

class RouteCard extends StatelessWidget {
  final String routeName;
  final String status;
  final int totalStops;
  final VoidCallback onTap;

  const RouteCard({
    super.key,
    required this.routeName,
    required this.status,
    required this.totalStops,
    required this.onTap,
  });

  Color get statusColor {
    switch (status) {
      case 'Em andamento':
        return Colors.orange;

      case 'Finalizada':
        return Colors.green;

      default:
        return Colors.blue;
    }
  }

  IconData get statusIcon {
    switch (status) {
      case 'Em andamento':
        return Icons.directions_car;

      case 'Finalizada':
        return Icons.check_circle;

      default:
        return Icons.schedule;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: statusColor.withValues(alpha: 0.15),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routeName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "$totalStops paradas",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}