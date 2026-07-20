import 'package:flutter/material.dart';

class StopCard extends StatelessWidget {
  final int order;
  final String customerName;
  final String address;
  final String status;

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onComplete;

  const StopCard({
    super.key,
    required this.order,
    required this.customerName,
    required this.address,
    required this.status,
    required this.onEdit,
    required this.onDelete,
    required this.onComplete,
  });

  Color get statusColor {
    switch (status) {
      case 'Concluída':
        return Colors.green;

      case 'Em andamento':
        return Colors.orange;

      default:
        return Colors.blue;
    }
  }

  IconData get statusIcon {
    switch (status) {
      case 'Concluída':
        return Icons.check_circle;

      case 'Em andamento':
        return Icons.local_shipping;

      default:
        return Icons.location_on;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [

                CircleAvatar(
                  backgroundColor: statusColor.withValues(alpha: 0.15),
                  child: Text(
                    order.toString(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        customerName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        address,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [

                          Icon(
                            statusIcon,
                            size: 18,
                            color: statusColor,
                          ),

                          const SizedBox(width: 5),

                          Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      )

                    ],
                  ),
                ),

              ],
            ),

            const Divider(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                IconButton(
                  onPressed: onComplete,
                  icon: const Icon(Icons.check_circle_outline),
                  tooltip: "Concluir",
                ),

                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  tooltip: "Editar",
                ),

                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  tooltip: "Excluir",
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}