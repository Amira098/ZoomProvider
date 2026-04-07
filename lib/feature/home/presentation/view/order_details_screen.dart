import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';
import 'status_update_screen.dart';
import 'store_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int requestId;

  const OrderDetailsScreen({super.key, required this.requestId});
  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'started_by_technical':
        return Colors.green;
      case 'completed':
        return Colors.teal;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<HomeCubit>()..getRequestsDetails(requestId),
      child: Scaffold(
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
                        Positioned.fill(
                          child: CustomPaint(
                            painter: ToolsPatternPainter(),
                          ),
                        ),
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            if (state is RequestDetailsLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is RequestDetailsFailure) {
                              return Center(
                                child: Text('Error: ${state.apiError?.message ?? "Something went wrong"}'),
                              );
                            } else if (state is RequestDetailsSuccess) {
                              final order = state.requestsDetailsModel.data;
                              if (order == null) {
                                return const Center(child: Text('Order not found'));
                              }
                              return SingleChildScrollView(
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
                                      child: Text(
                                        order.status?.label ?? 'No Status',
                                        style: const TextStyle(
                                          color: AppColors.accentRed,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Builder(
                                      builder: (context) {
                                        final hasLatLng = order.latitude != null && order.longitude != null;
                                        final hasAddress = order.address != null && order.address!.trim().isNotEmpty;

                                        String? mapUrl;

                                        if (hasLatLng) {
                                          mapUrl =
                                          'https://maps.googleapis.com/maps/api/staticmap'
                                              '?center=${order.latitude},${order.longitude}'
                                              '&zoom=14'
                                              '&size=600x300'
                                              '&markers=color:red%7C${order.latitude},${order.longitude}'
                                              '&key=$googleMapsApiKey';
                                        } else if (hasAddress) {
                                          final encodedAddress = Uri.encodeComponent(order.address!);
                                          mapUrl =
                                          'https://maps.googleapis.com/maps/api/staticmap'
                                              '?center=$encodedAddress'
                                              '&zoom=14'
                                              '&size=600x300'
                                              '&markers=color:red%7C$encodedAddress'
                                              '&key=$googleMapsApiKey';
                                        }

                                        final statusLabel = order.status?.label ?? 'Unknown';
                                        final statusValue = order.status?.value ?? '';

                                        final statusColor = _getStatusColor(statusValue);

                                        return Container(
                                          height: 180,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: Colors.grey.withOpacity(0.3)),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: mapUrl != null
                                                    ? Image.network(
                                                  mapUrl,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Container(
                                                      color: Colors.grey.shade200,
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.location_off,
                                                          size: 50,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                                    : Container(
                                                  color: Colors.grey.shade200,
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.location_on,
                                                      size: 50,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    _buildSectionTitle('Customer data'),
                                    _buildDataContainer([
                                      _buildDataRow(order.customer?.name ?? 'N/A', 'Name'),
                                      _buildDataRow(order.customer?.phone ?? 'N/A', 'Phone'),
                                      _buildDataRow(order.address ?? 'N/A', 'Address'),
                                      // _buildDataRow('3.2 km', 'Distance'),
                                    ]),
                                    const SizedBox(height: 24),
                                    _buildSectionTitle('Service details'),
                                    _buildDataContainer([
                                      _buildDataRow(
                                          order.products?.map((e) => e.name).join(', ') ?? 'N/A', 'Service type'),
                                      _buildDataRow('# ORD- ${order.code ?? order.id}', 'Order Code'),
                                      _buildDataRow(
                                          order.products?.map((e) => '${e.name} (x${e.quantity})').join('\n') ?? 'N/A',
                                          'Materials'),
                                      // _buildDataRow('OMR 560.00', 'Service value'),
                                      _buildDataRow(order.customerDate ?? order.createdAt ?? 'N/A', 'Implementation date'),
                                    ]),
                                    const SizedBox(height: 24),
                                    if (order.customerNotes != null && order.customerNotes!.isNotEmpty) ...[
                                      _buildSectionTitle('Notice'),
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.grey.withOpacity(0.1)),
                                        ),
                                        child: Text(
                                          order.customerNotes!,
                                          style: const TextStyle(fontSize: 13, height: 1.5),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                    ],
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
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
