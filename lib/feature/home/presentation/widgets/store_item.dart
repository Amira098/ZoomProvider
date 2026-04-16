import 'package:flutter/material.dart';

class StoreItem extends StatelessWidget {
  final String title;
  final String code;
  final String quantity;
  final String status;
  final Color statusColor;
  final Color statusTextColor;

  const StoreItem({
    super.key,
    required this.title,
    required this.code,
    required this.quantity,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              //   decoration: BoxDecoration(
              //     color: statusColor,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Text(
              //     status,
              //     style: TextStyle(
              //       fontSize: 10,
              //       color: statusTextColor,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            code,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'Quantity: $quantity',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
