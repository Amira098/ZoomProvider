import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../data/model/request_card_data.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';
import '../widgets/request_card.dart';
import '../widgets/statistics_section.dart';
import 'store_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                              final homeModel = state.homeModel;
                              final orders = homeModel.data ?? [];

                              final newOrders = orders
                                  .where((o) => o.status?.value != 'completed')
                                  .toList();

                              final completedOrders = orders
                                  .where((o) => o.status?.value == 'completed')
                                  .toList();

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
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(20),
                                  physics:
                                  const AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 25),
                                      StatisticsSection(
                                        stats: homeModel.stats,
                                      ),
                                      const SizedBox(height: 25),

                                      if (newOrders.isNotEmpty) ...[
                                        Text(
                                          'New requests',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        ...newOrders.map(
                                              (order) => RequestCard(
                                            order: mapToRequestCardData(order),
                                          ),
                                        ),
                                      ],

                                      if (completedOrders.isNotEmpty) ...[
                                        const SizedBox(height: 20),
                                        const Text(
                                          'Completed today',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        ...completedOrders.map(
                                              (order) => RequestCard(
                                            order: mapToRequestCardData(order),
                                          ),
                                        ),
                                      ],

                                      if (orders.isEmpty)
                                        const Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 40),
                                            child: Text('No requests found'),
                                          ),
                                        ),
                                    ],
                                  ),
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