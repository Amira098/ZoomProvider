import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../data/model/requests_details_model.dart';
import '../view_model/home/home_cubit.dart';
import '../view_model/home/home_state.dart';
import '../view_model/receive_order/receive_order_cubit.dart';
import '../view_model/receive_order/receive_order_state.dart';
import '../view_model/start_order/start_order_cubit.dart';
import '../view_model/start_order/start_order_state.dart';
import '../view_model/unsuspend_order/unsuspend_order_cubit.dart';
import '../view_model/unsuspend_order/unsuspend_order_state.dart';
import 'status_update_screen.dart';
import 'store_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int requestId;

  const OrderDetailsScreen({
    super.key,
    required this.requestId,
  });

  Color _getStatusBackgroundColor(String? status) {
    switch (status) {
      case 'pending':
        return Colors.orange.withOpacity(0.15);
      case 'accepted':
        return Colors.blue.withOpacity(0.15);
      case 'started_by_technical':
        return Colors.green.withOpacity(0.15);
      case 'completed':
      case 'completed_unpaid':
        return Colors.teal.withOpacity(0.15);
      case 'cancelled':
        return Colors.red.withOpacity(0.15);
      case 'suspended':
        return Colors.brown.withOpacity(0.15);
      case 'assigned_to_technician':
        return AppColors.paleBlue2;
      case 'order_is_done_from_warehose':
        return AppColors.paleOrange;
      default:
        return Colors.grey.withOpacity(0.15);
    }
  }

  Color _getStatusTextColor(String? status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'started_by_technical':
        return Colors.green;
      case 'completed':
      case 'completed_unpaid':
        return Colors.teal;
      case 'cancelled':
        return Colors.red;
      case 'suspended':
        return Colors.brown;
      case 'assigned_to_technician':
        return AppColors.primary;
      case 'order_is_done_from_warehose':
        return AppColors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          serviceLocator<HomeCubit>()..getRequestsDetails(requestId),
        ),
        BlocProvider(
          create: (context) => serviceLocator<ReceiveOrderCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<StartOrderCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<UnsuspendOrderCubit>(),
        ),
      ],
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
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
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
                        MultiBlocListener(
                          listeners: [
                            BlocListener<ReceiveOrderCubit, ReceiveOrderState>(
                              listener: (context, state) {
                                if (state is ReceiveOrderSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Order received successfully')));
                                  context.read<HomeCubit>().getRequestsDetails(requestId);
                                } else if (state is ReceiveOrderFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(state.apiError?.message.toString() ?? 'Failed to receive order')));
                                }
                              },
                            ),
                            BlocListener<StartOrderCubit, StartOrderState>(
                              listener: (context, state) {
                                if (state is StartOrderSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Order started successfully')));
                                  context.read<HomeCubit>().getRequestsDetails(requestId);
                                } else if (state is StartOrderFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(state.apiError?.message.toString() ?? 'Failed to start order')));
                                }
                              },
                            ),
                            BlocListener<UnsuspendOrderCubit, UnsuspendOrderState>(
                              listener: (context, state) {
                                if (state is UnsuspendOrderSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Order unsuspended successfully')));
                                  context.read<HomeCubit>().getRequestsDetails(requestId);
                                } else if (state is UnsuspendOrderFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(state.apiError?.message .toString()?? 'Failed to unsuspend order')));
                                }
                              },
                            ),
                          ],
                          child: BlocBuilder<HomeCubit, HomeState>(
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
                                            mapUrl = 'https://maps.googleapis.com/maps/api/staticmap'
                                                '?center=${order.latitude},${order.longitude}'
                                                '&zoom=14'
                                                '&size=600x300'
                                                '&markers=color:red%7C${order.latitude},${order.longitude}'
                                                '&key=$googleMapsApiKey';
                                          } else if (hasAddress) {
                                            final encodedAddress = Uri.encodeComponent(order.address!);
                                            mapUrl = 'https://maps.googleapis.com/maps/api/staticmap'
                                                '?center=$encodedAddress'
                                                '&zoom=14'
                                                '&size=600x300'
                                                '&markers=color:red%7C$encodedAddress'
                                                '&key=$googleMapsApiKey';
                                          }

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
                                        _buildDataRow(order.customer ?? '-', 'Name'),
                                        _buildDataRow(order.address ?? '-', 'Address'),
                                      ]),
                                      const SizedBox(height: 24),
                                      _buildSectionTitle('Service details'),
                                      _buildDataContainer([
                                        _buildDataRow(order.products?.map((e) => e.name).join(', ') ?? 'N/A', 'Service type'),
                                        _buildDataRow('# ORD- ${order.code ?? order.id}', 'Order Code'),
                                        _buildDataRow(
                                            order.products?.map((e) => '${e.name} (x${e.quantity})').join('\n') ?? 'N/A', 'Materials'),
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
                                      if (order.status?.value == 'order_is_done_from_warehose')
                                        BlocBuilder<ReceiveOrderCubit, ReceiveOrderState>(
                                          builder: (context, receiveState) {
                                            return Column(
                                              children: [
                                                _buildActionButton(
                                                  'Receive job',
                                                  AppColors.accentRed,
                                                  isLoading: receiveState is ReceiveOrderLoading,
                                                  onPressed: () {
                                                    context.read<ReceiveOrderCubit>().receiveOrder(order.id!);
                                                  },
                                                ),
                                                const SizedBox(height: 12),
                                              ],
                                            );
                                          },
                                        ),
                                      if (order.status?.value == 'received_by_technical')
                                        BlocBuilder<StartOrderCubit, StartOrderState>(
                                          builder: (context, startState) {
                                            return Column(
                                              children: [
                                                _buildActionButton(
                                                  'start job',
                                                  AppColors.accentRed,
                                                  isLoading: startState is StartOrderLoading,
                                                  onPressed: () {
                                                    context.read<StartOrderCubit>().startOrder(order.id!);
                                                  },
                                                ),
                                                const SizedBox(height: 12),
                                              ],
                                            );
                                          },
                                        ),
                                      if (order.status?.value == 'suspended_by_technical')
                                        BlocBuilder<UnsuspendOrderCubit, UnsuspendOrderState>(
                                          builder: (context, unsuspendState) {
                                            return Column(
                                              children: [
                                                _buildActionButton(
                                                  'Unsuspend job',
                                                  Colors.green,
                                                  isLoading: unsuspendState is UnsuspendOrderLoading,
                                                  onPressed: () {
                                                    context.read<UnsuspendOrderCubit>().unsuspendOrder(order.id!);
                                                  },
                                                ),
                                                const SizedBox(height: 12),
                                              ],
                                            );
                                          },
                                        ),
                                      if (order.status?.value == 'started_by_technical')
                                        _buildActionButton(
                                          'Status update',
                                          AppColors.accentRed,
                                          onPressed: () async {
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => StatusUpdateScreen(
                                                  orderId: order.id!,
                                                  customerName: order.customer??'',
                                                ),
                                              ),
                                            );
                                            if (result == true) {
                                              context.read<HomeCubit>().getRequestsDetails(requestId);
                                            }
                                          },
                                        ),
                                      const SizedBox(height: 20),
                                      const SizedBox(height: 40),
                                    ],
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
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
      ),
    );
  }

  Widget _buildMapSection(OrderModel order) {
    final hasLat = order.latitude != null && order.latitude!.trim().isNotEmpty;
    final hasLng = order.longitude != null && order.longitude!.trim().isNotEmpty;
    final hasLatLng = hasLat && hasLng;
    final hasAddress = order.address != null && order.address!.trim().isNotEmpty;

    String? mapUrl;

    if (hasLatLng) {
      mapUrl = 'https://maps.googleapis.com/maps/api/staticmap'
          '?center=${order.latitude},${order.longitude}'
          '&zoom=14'
          '&size=600x300'
          '&markers=color:red%7C${order.latitude},${order.longitude}'
          '&key=$googleMapsApiKey';
    } else if (hasAddress) {
      final encodedAddress = Uri.encodeComponent(order.address!);
      mapUrl = 'https://maps.googleapis.com/maps/api/staticmap'
          '?center=$encodedAddress'
          '&zoom=14'
          '&size=600x300'
          '&markers=color:red%7C$encodedAddress'
          '&key=$googleMapsApiKey';
    }

    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      clipBehavior: Clip.antiAlias,
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
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.withOpacity(0.1),
                  indent: 16,
                  endIndent: 16,
                ),
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
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String label,
      Color color, {
        VoidCallback? onPressed,
        bool isLoading = false,
      }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}