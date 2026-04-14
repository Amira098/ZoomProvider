import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../generated/locale_keys.g.dart';

import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../data/model/all_requests_model.dart';
import '../../data/model/request_card_data.dart';
import '../view_model/home/home_cubit.dart';
import '../view_model/home/home_state.dart';
import '../widgets/request_card.dart';
import 'store_screen.dart';

class AllRequestsScreen extends StatelessWidget {
  const AllRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<HomeCubit>()..getAllRequests(),
      child: const _AllRequestsView(),
    );
  }
}

class _AllRequestsView extends StatelessWidget {
  const _AllRequestsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _Header(),
            const _Body(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Expanded(
            child: Text(
              LocaleKeys.general_all_requests.tr(),
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
                  builder: (_) => const StoreScreen(),
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
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  if (state is AllRequestsLoading) {
                    return Skeletonizer(
                      enabled: true,
                      child: _buildListContent(
                        context,
                        _getDummyAllRequestsModel(),
                      ),
                    );
                  }

                  if (state is AllRequestsFailure) {
                    return Center(
                      child: Text(
                        state.apiError?.message?.toString() ??
                            LocaleKeys.error_SomethingWentWrong.tr(),
                      ),
                    );
                  }

                  if (state is AllRequestsSuccess) {
                    final orders = state.allRequestsModel.data ?? [];

                    if (orders.isEmpty) {
                      return const _EmptyState();
                    }

                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<HomeCubit>().getAllRequests(),
                      child: _buildListContent(context, state.allRequestsModel),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListContent(BuildContext context, AllRequestsModel model) {
    final orders = model.data ?? [];
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = orders[index];

        final cardData = RequestCardData(
          id: item.id,
          code: (item.code ?? item.id ?? '').toString(),
          customerName: item.customer ?? 'Unknown Customer',
          address: item.address ?? '',
          date: item.customerDate ?? item.createdAt ?? '',
          note: item.customerNotes ??
              (item.products?.isNotEmpty == true
                  ? item.products!.first.name ?? ''
                  : ''),
          statusValue: item.status?.value ?? '',
          statusLabel: item.status?.label ?? '',
        );

        return RequestCard(order: cardData);
      },
    );
  }

  AllRequestsModel _getDummyAllRequestsModel() {
    return AllRequestsModel(
      data: List.generate(
        6,
        (index) => OrderModel(
          id: index,
          code: 12345,
          customer: 'Customer Name ' * 2,
          address: 'Address Details ' * 3,
          customerDate: '2023-01-01',
          customerNotes: 'Order notes go here ' * 5,
          status: StatusModel(label: 'Status', value: 'new'),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_outlined, size: 60, color: Colors.grey),
          const SizedBox(height: 10),
          Text(
            LocaleKeys.Home_no_requests_found.tr(),
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}