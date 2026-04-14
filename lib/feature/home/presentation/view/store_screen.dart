import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../generated/locale_keys.g.dart';
import '../widgets/authorization_header.dart';
import '../widgets/store_item.dart';
class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                    Expanded(
                    child: Text(
                        LocaleKeys.Home_store_title.tr(),
                      textAlign: TextAlign.center,
                        style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: ToolsPatternPainter(),
                        ),
                      ),
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                LocaleKeys.Home_approved_disbursement_requests.tr(args: ['Tuesday, March 24']),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.red.withOpacity(0.3)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Text('✅', style: TextStyle(fontSize: 16)),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      LocaleKeys.Home_disbursement_approved_msg.tr(args: ['#WH-0091']),
                                      style: const TextStyle(
                                        color: AppColors.accentRed,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.notifications, color: Colors.red.shade400),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            AuthorizationHeader(id: '#WH-0091', status: LocaleKeys.Home_certified.tr()),
                            const SizedBox(height: 12),
                            const StoreItem(
                              title: '5-stage RO filter',
                              code: 'FLT-RO-001 | Location: Shelf A-12',
                              quantity: '1 unit',
                              status: 'ready',
                              statusColor: AppColors.paleGreen,
                              statusTextColor: Color(0xFF27AE60),
                            ),
                            const StoreItem(
                              title: '10 inch PP candle',
                              code: 'CND-PP-010 | Location: Shelf B-04',
                              quantity: '3 pieces',
                              status: 'ready',
                              statusColor: AppColors.paleGreen,
                              statusTextColor: Color(0xFF27AE60),
                            ),
                            const StoreItem(
                              title: 'Carbon block filter',
                              code: 'CRB-BLK-05 | Location: Shelf C-07',
                              quantity: '1 unit',
                              status: 'expected',
                              statusColor: AppColors.paleOrange,
                              statusTextColor: AppColors.orange,
                            ),
                            const SizedBox(height: 12),
                            AuthorizationHeader(
                              id: '#WH-0089',
                              status: LocaleKeys.Home_recipient.tr(),
                              headerColor: AppColors.palePurple,
                              textColor: AppColors.darkrose,
                            ),
                            const SizedBox(height: 12),
                            const StoreItem(
                              title: 'Granular candle',
                              code: 'KIT-STD-02 | Request by Sarah Ibrahim',
                              quantity: '1 unit',
                              status: 'recipient',
                              statusColor: AppColors.palePurple,
                              statusTextColor: AppColors.darkrose,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accentRed,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  LocaleKeys.Home_confirm_receipt.tr(args: ['#WH-0091']),
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
