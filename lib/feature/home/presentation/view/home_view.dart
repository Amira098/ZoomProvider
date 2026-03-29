import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/earnings_card.dart';
import '../widgets/request_card.dart';
import '../widgets/statistics_section.dart';
import 'store_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('👋', style: TextStyle(fontSize: 24)),
                  const Spacer(),
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
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const EarningsCard(),
                            const SizedBox(height: 25),
                            const StatisticsSection(),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'New requests',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'See All',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const RequestCard(
                              id: '#ORD-2234',
                              name: 'Mahmoud Abdullah',
                              location: 'Republic Street, Maadi — 3.2 km',
                              time: 'Today 11:00 AM',
                              description: 'Disbursement authorization #WH-0091 — Ready',
                              status: 'New',
                              statusColor: AppColors.paleBlue2,
                              statusTextColor: Color(0xFF4A90E2),
                              type: 'Filter installation',
                            ),
                            const RequestCard(
                              id: '#ORD-2198',
                              name: 'Sarah Ibrahim',
                              location: 'Nasr City, Ahmed Orabi Street — 1.8 km',
                              time: 'Today 10:00 AM',
                              description: 'Disbursement authorization #WH-0089 — Received',
                              status: 'In the way',
                              statusColor: AppColors.paleOrange,
                              statusTextColor: AppColors.orange,
                              type: 'Change candle',
                            ),
                            const RequestCard(
                              id: '#ORD-2178',
                              name: 'Karim Al-Sayed',
                              location: 'Helwan, Nile Street — 5.4 km',
                              time: 'Today 9:30 AM',
                              description: 'It started 42 minutes ago',
                              status: 'In Progress',
                              statusColor: Color(0xFFE2F9E2),
                              statusTextColor: Color(0xFF27AE60),
                              type: 'Change candle',
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Completed today',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const RequestCard(
                              id: '#ORD-2178',
                              name: 'Heba Ramadan',
                              location: '',
                              time: 'Finished 8:45 AM',
                              description: 'Installation completed and payment made — OMR 450',
                              status: 'Complete',
                              statusColor: AppColors.paleRed,
                              statusTextColor: AppColors.accentRed,
                              type: 'Filter installation',
                              isCompleted: true,
                            ),
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
