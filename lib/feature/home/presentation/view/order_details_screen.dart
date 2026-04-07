import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import 'status_update_screen.dart';
import 'store_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

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
                      'Order details',
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

                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.paleRed,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                'New — Awaiting action',
                                style: TextStyle(
                                  color: AppColors.accentRed,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 180,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                                image: const DecorationImage(
                                  image: NetworkImage('https://maps.googleapis.com/maps/api/staticmap?center=30.0444,31.2357&zoom=14&size=600x300&markers=color:yellow%7C30.0444,31.2357'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 12,
                                    left: 12,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF27AE60).withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Text(
                                        'Open',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            _buildSectionTitle('Customer data'),
                            _buildDataContainer([
                              _buildDataRow('Mahmoud Abdullah', 'Name'),
                              _buildDataRow('0100-123-4567', 'Phone'),
                              _buildDataRow('12 Al Gomhouria Street, Maadi', 'Address'),
                              _buildDataRow('3.2 km', 'Distance'),
                            ]),
                            const SizedBox(height: 24),
                            _buildSectionTitle('Service details'),
                            _buildDataContainer([
                              _buildDataRow('Installing a 5-stage filter', 'Service type'),
                              _buildDataRow('WH-0091', 'Exchange permission'),
                              _buildDataRow('5-stage filter + 3 candles', 'Materials'),
                              _buildDataRow('OMR 560.00', 'Service value'),
                              _buildDataRow('Today 11:00 AM', 'Implementation date'),
                            ]),
                            const SizedBox(height: 24),
                            _buildSectionTitle('Notice'),
                            Container(
                              padding: const EdgeInsets.all(16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.withOpacity(0.1)),
                              ),
                              child: const Text(
                                'The customer prefers under-sink installation. Access is via the side door. Please call 15 minutes prior to arrival.',
                                style: TextStyle(fontSize: 13, height: 1.5),
                              ),
                            ),
                            const SizedBox(height: 24),
                            _buildActionButton('Start job', AppColors.accentRed),
                            const SizedBox(height: 12),
                            _buildActionButton('I reached the client — work began', AppColors.accentRed),
                            const SizedBox(height: 12),
                            _buildActionButton(
                              'Status update',
                              AppColors.accentRed,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const StatusUpdateScreen(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                              ),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Clicking will send an immediate notification to the admin and route manager.',
                                      style: TextStyle(color: AppColors.accentRed, fontSize: 12),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.notifications, color: Colors.red.shade400),
                                ],
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

  Widget _buildSectionTitle(String title) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDataContainer(List<Widget> rows) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        children: List.generate(rows.length, (index) {
          return Column(
            children: [
              rows[index],
              if (index < rows.length - 1)
                Divider(height: 1, thickness: 1, color: Colors.grey.withOpacity(0.1), indent: 16, endIndent: 16),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDataRow(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, {VoidCallback? onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
