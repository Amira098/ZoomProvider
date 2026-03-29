import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/view/store_screen.dart';
import '../../../home/presentation/widgets/request_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
                  const Expanded(
                    child: Text(
                      'Notification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StoreScreen(),
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/svg/shopping_cart.svg',
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      width: 24,
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
                      ListView(
                        padding: const EdgeInsets.all(20),
                        children: const [
                          RequestCard(
                            id: '#ORD-2234',
                            name: 'Mahmoud Abdullah',
                            location: 'Republic Street, Maadi — 3.2 km',
                            time: 'Today 11:00 AM',
                            description: 'Disbursement authorization #WH-0091 — Ready',
                            status: 'New',
                            statusColor: Color(0xFFD9E9FF),
                            statusTextColor: Color(0xFF4A90E2),
                            type: 'Filter installation',
                          ),
                          RequestCard(
                            id: '#ORD-2234',
                            name: 'Mahmoud Abdullah',
                            location: 'Republic Street, Maadi — 3.2 km',
                            time: 'Today 11:00 AM',
                            description: 'Disbursement authorization #WH-0091 — Ready',
                            status: 'New',
                            statusColor: Color(0xFFD9E9FF),
                            statusTextColor: Color(0xFF4A90E2),
                            type: 'Filter installation',
                          ),
                        ],
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
