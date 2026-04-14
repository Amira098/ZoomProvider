import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zoom_provider/feature/home/presentation/view/status_updates_screen_wrapper.dart';
import 'package:zoom_provider/generated/locale_keys.g.dart';

import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../data/model/requests_details_model.dart';
import '../view_model/completed_paid/completed_paid_cubit.dart';
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
        BlocProvider(
          create: (context) => serviceLocator<CompletedPaidCubit>(),
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
                    Expanded(
                      child: Text(
                        LocaleKeys.OrderDetails_Title.tr(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
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
                                      SnackBar(content: Text(LocaleKeys.OrderDetails_ReceivedSuccess.tr())));
                                  context.read<HomeCubit>().getRequestsDetails(requestId);
                                } else if (state is ReceiveOrderFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(state.apiError?.message.toString() ?? LocaleKeys.OrderDetails_FailedReceive.tr())));
                                }
                              },
                            ),
                            BlocListener<StartOrderCubit, StartOrderState>(
                              listener: (context, state) {
                                if (state is StartOrderSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(LocaleKeys.OrderDetails_StartedSuccess.tr())));
                                  context.read<HomeCubit>().getRequestsDetails(requestId);
                                } else if (state is StartOrderFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(state.apiError?.message.toString() ?? LocaleKeys.OrderDetails_FailedStart.tr())));
                                }
                              },
                            ),
                            BlocListener<UnsuspendOrderCubit, UnsuspendOrderState>(
                              listener: (context, state) {
                                if (state is UnsuspendOrderSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(LocaleKeys.OrderDetails_UnsuspendedSuccess.tr())));
                                  context.read<HomeCubit>().getRequestsDetails(requestId);
                                } else if (state is UnsuspendOrderFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(state.apiError?.message.toString() ?? LocaleKeys.OrderDetails_FailedUnsuspend.tr())));
                                }
                              },
                            ),
                          ],
                          child: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              if (state is RequestDetailsLoading) {
                                return Skeletonizer(
                                  enabled: true,
                                  child: _buildOrderDetailsContent(
                                    context,
                                    _getDummyOrderModel(),
                                  ),
                                );
                              } else if (state is RequestDetailsFailure) {
                                return Center(
                                  child: Text('${LocaleKeys.OrderDetails_Error.tr()}: ${state.apiError?.message ?? LocaleKeys.error_SomethingWentWrong.tr()}'),
                                );
                              } else if (state is RequestDetailsSuccess) {
                                final order = state.requestsDetailsModel.data;
                                if (order == null) {
                                  return Center(
                                      child: Text(
                                          LocaleKeys.OrderDetails_NotFound.tr()));
                                }
                                return _buildOrderDetailsContent(context, order);
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

  Widget _buildSectionTitle(String title) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget _buildDataContainer(List<Widget> rows) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        children: List.generate(rows.length, (index) {
          return Column(
            children: [
              rows[index],
              if (index < rows.length - 1)
                Divider(
                  height: 1.h,
                  thickness: 1.h,
                  color: Colors.grey.withOpacity(0.1),
                  indent: 16.w,
                  endIndent: 16.w,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildOrderDetailsContent(BuildContext context, OrderModel order) {
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
              final hasLatLng =
                  order.latitude != null && order.longitude != null;
              final hasAddress =
                  order.address != null && order.address!.trim().isNotEmpty;

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
          _buildSectionTitle(LocaleKeys.OrderDetails_CustomerData.tr()),
          _buildDataContainer([
            _buildDataRow(
                order.customer ?? '-', LocaleKeys.OrderDetails_Name.tr()),
            _buildDataRow(
                order.address ?? '-', LocaleKeys.OrderDetails_Address.tr()),
          ]),
          const SizedBox(height: 24),
          _buildSectionTitle(LocaleKeys.OrderDetails_ServiceDetails.tr()),
          _buildDataContainer([
            _buildDataRow(order.products?.map((e) => e.name).join(', ') ?? 'N/A',
                LocaleKeys.OrderDetails_ServiceType.tr()),
            _buildDataRow('# ORD- ${order.code ?? order.id}',
                LocaleKeys.OrderDetails_OrderCode.tr()),
            _buildDataRow(
                order.products
                        ?.map((e) => '${e.name} (x${e.quantity})')
                        .join('\n') ??
                    'N/A',
                LocaleKeys.OrderDetails_Materials.tr()),
            _buildDataRow(order.customerDate ?? order.createdAt ?? 'N/A',
                LocaleKeys.OrderDetails_ImplementationDate.tr()),
          ]),
          const SizedBox(height: 24),
          if (order.customerNotes != null && order.customerNotes!.isNotEmpty) ...[
            _buildSectionTitle(LocaleKeys.OrderDetails_Notice.tr()),
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
                      LocaleKeys.OrderDetails_ReceiveJob.tr(),
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
                      LocaleKeys.OrderDetails_StartJob.tr(),
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
                      LocaleKeys.OrderDetails_UnsuspendJob.tr(),
                      Colors.green,
                      isLoading: unsuspendState is UnsuspendOrderLoading,
                      onPressed: () {
                        context
                            .read<UnsuspendOrderCubit>()
                            .unsuspendOrder(order.id!);
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),
          if (order.status?.value == 'started_by_technical')
            _buildActionButton(
              LocaleKeys.OrderDetails_StatusUpdate.tr(),
              AppColors.accentRed,
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatusUpdateScreenWrapper(
                      orderId: order.id!,
                      servicesIds: order.products
                              ?.map((e) => e.id)
                              .whereType<int>()
                              .toList() ??
                          [],
                      customerName: order.customer ?? '',
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

  OrderModel _getDummyOrderModel() {
    return OrderModel(
      id: 1,
      code: 12345,
      customer: 'Customer Name ' * 2,
      address: 'Address Details ' * 3,
      customerDate: '2023-01-01',
      customerNotes: 'Order notes go here ' * 5,
      status: StatusModel(label: 'Status Label', value: 'new'),
      products: [
        ProductModel(name: 'Product Name', quantity: 1),
      ],
    );
  }

  Widget _buildDataRow(String value, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
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
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.w,
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}