import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import 'request_card.dart';
import 'store_screen.dart';

class AllRequestsScreen extends StatelessWidget {
  const AllRequestsScreen({super.key});

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
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const Expanded(
                    child: Text(
                      'All requests',
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
                          RequestCard(
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
