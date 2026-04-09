import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../home/data/model/request_card_data.dart';
import '../../../home/presentation/view/store_screen.dart';
import '../../../home/presentation/view_model/home/home_cubit.dart';
import '../../../home/presentation/view_model/home/home_state.dart';
import '../../../home/presentation/widgets/request_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<HomeCubit>()..getHomeData(),
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

                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            if (state is HomeLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is HomeFailure) {
                              return Center(
                                child: Text(
                                  state.apiError?.message?.toString() ??
                                      'Something went wrong',
                                ),
                              );
                            } else if (state is HomeSuccess) {
                              final orders = state.homeModel.data ?? [];

                              if (orders.isEmpty) {
                                return const Center(
                                  child: Text('No notifications found'),
                                );
                              }

                              RequestCardData mapToRequestCardData(order) {
                                return RequestCardData(
                                  id: order.id,
                                  code: (order.code ?? order.id ?? '').toString(),
                                  customerName:
                                  order.customer?.name ?? 'Unknown Customer',
                                  address: order.address ?? '',
                                  date: order.customerDate ?? order.createdAt ?? '',
                                  note: order.customerNotes ??
                                      (order.products?.isNotEmpty == true
                                          ? order.products!.first.name ?? ''
                                          : ''),
                                  statusValue: order.status?.value ?? '',
                                  statusLabel: order.status?.label ?? '',
                                );
                              }

                              return RefreshIndicator(
                                onRefresh: () =>
                                    context.read<HomeCubit>().getHomeData(),
                                child: ListView.separated(
                                  padding: const EdgeInsets.all(20),
                                  itemCount: orders.length,
                                  separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    return RequestCard(
                                      order: mapToRequestCardData(
                                        orders[index],
                                      ),
                                    );
                                  },
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
}