import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/model/home_model.dart';
import '../view/order_details_screen.dart';

class RequestCard extends StatelessWidget {
  final OrderModel order;

  const RequestCard({
    super.key,
    required this.order,
  });

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'new':
        return AppColors.paleBlue2;
      case 'pending':
        return AppColors.paleOrange;
      case 'completed':
        return AppColors.paleRed;
      default:
        return AppColors.primary;
    }
  }

  Color _getStatusTextColor(String? status) {
    switch (status) {
      case 'new':
        return AppColors.primary;
      case 'pending':
        return AppColors.orange;
      case 'completed':
        return AppColors.accentRed;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = order.status?.value;
    final statusLabel = order.status?.label ?? '';
    final statusColor = _getStatusColor(status);
    final statusTextColor = _getStatusTextColor(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryLight.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '# ORD- ${order.code ?? order.id ?? ""}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              if (order.status?.label != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),

                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: 10,
                      color: statusTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            order.customer?.name ?? 'Unknown Customer',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          if (order.address != null && order.address!.isNotEmpty)
            Text(
              order.address!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          const SizedBox(height: 4),
          Text(
            order.customerDate ?? order.createdAt ?? '',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            order.customerNotes ?? (order.products?.isNotEmpty == true ? order.products!.first.name ?? "" : ""),
            style: const TextStyle(fontSize: 12, color: Colors.black87),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (order.id != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(requestId: order.id!),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'View details',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
