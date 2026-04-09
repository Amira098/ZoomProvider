import 'package:flutter/material.dart';
import 'package:zoom_provider/feature/home/presentation/view/order_details_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/model/request_card_data.dart';

class RequestCard extends StatelessWidget {
  final RequestCardData order;

  const RequestCard({
    super.key,
    required this.order,
  });

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'new':
      case 'assigned_to_technician':
      case 'started_by_technical':
        return AppColors.paleBlue2;

      case 'pending':
      case 'order_is_done_from_warehose':
        return AppColors.paleOrange;

      case 'completed':
      case 'completed_unpaid':
        return AppColors.paleRed;

      default:
        return AppColors.primary.withOpacity(0.1);
    }
  }

  Color _getStatusTextColor(String? status) {
    switch (status) {
      case 'new':
      case 'assigned_to_technician':
      case 'started_by_technical':
        return AppColors.blue500;

      case 'pending':
      case 'order_is_done_from_warehose':
        return AppColors.orange;

      case 'completed':
      case 'completed_unpaid':
        return AppColors.accentRed;

      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order.statusValue);
    final statusTextColor = _getStatusTextColor(order.statusValue);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryLight.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '# ORD- ${order.code}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              if (order.statusLabel.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    order.statusLabel,
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
            order.customerName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          if (order.address.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              order.address,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text(
            order.date,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            order.note,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
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
                        builder: (context) => OrderDetailsScreen(
                          requestId: order.id!,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
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