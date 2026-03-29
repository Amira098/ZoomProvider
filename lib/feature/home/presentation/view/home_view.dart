import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import 'request_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildEarningsCard() {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8585), Color(0xFFFF5252)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your earnings',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              Spacer(),
            ],
          ),
          const Positioned(
            right: 0,
            top: 0,
            child: Icon(Icons.more_vert, color: Colors.white70),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _ChartPainter(),
            ),
          ),
          Positioned(
            right: 20,
            top: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFF2A2A),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: const Text(
                'OMR560.00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'statistics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: const Column(
              children: [
                Text(
                  '100',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Number of requests',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('20', 'Canceled requests'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatItem('50', 'Completed requests'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatItem('30', 'Pending requests'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161A22),
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
                  SvgPicture.asset(
                    'assets/svg/shopping_cart.svg',
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    width: 24,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xffF6F6F6),
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
                            _buildEarningsCard(),
                            const SizedBox(height: 25),
                            _buildStatisticsSection(),
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
                              statusColor: Color(0xFFD9E9FF),
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
                              statusColor: Color(0xFFFFF4D9),
                              statusTextColor: Color(0xFFD8891E),
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
                              statusColor: Color(0xFFFFDADA),
                              statusTextColor: Color(0xFFFF2A2A),
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

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.1, size.height * 0.65);
    path.lineTo(size.width * 0.2, size.height * 0.8);
    path.lineTo(size.width * 0.3, size.height * 0.6);
    path.lineTo(size.width * 0.4, size.height * 0.75);
    path.lineTo(size.width * 0.5, size.height * 0.4); // Peak
    path.lineTo(size.width * 0.6, size.height * 0.6);
    path.lineTo(size.width * 0.7, size.height * 0.5);
    path.lineTo(size.width * 0.8, size.height * 0.85);
    path.lineTo(size.width * 0.9, size.height * 0.75);
    path.lineTo(size.width, size.height * 0.8);

    canvas.drawPath(path, paint);

    final fillPath = Path();
    fillPath.moveTo(0, size.height * 0.7);
    fillPath.lineTo(size.width * 0.1, size.height * 0.65);
    fillPath.lineTo(size.width * 0.2, size.height * 0.8);
    fillPath.lineTo(size.width * 0.3, size.height * 0.6);
    fillPath.lineTo(size.width * 0.4, size.height * 0.75);
    fillPath.lineTo(size.width * 0.5, size.height * 0.4); // Peak
    fillPath.lineTo(size.width * 0.6, size.height * 0.6);
    fillPath.lineTo(size.width * 0.7, size.height * 0.5);
    fillPath.lineTo(size.width * 0.8, size.height * 0.85);
    fillPath.lineTo(size.width * 0.9, size.height * 0.75);
    fillPath.lineTo(size.width, size.height * 0.8);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Draw the dot at the peak
    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 4, dotPaint);
    final dotStrokePaint = Paint()
      ..color = const Color(0xFF161A22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 4, dotStrokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
