import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_provider/feature/home/presentation/view/order_details_screen.dart';
import 'package:zoom_provider/generated/locale_keys.g.dart';
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
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
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
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              if (order.statusLabel.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    order.statusLabel,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: statusTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            order.customerName,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          if (order.address.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              order.address,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
          ],
          SizedBox(height: 4.h),
          Text(
            order.date,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            order.note,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16.h),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 8.h,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  LocaleKeys.Home_view_details.tr(),
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}