import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../view_model/complete_order/complete_order_cubit.dart';
import '../view_model/complete_order/complete_order_state.dart';
import '../view_model/suspend_order/suspend_order_cubit.dart';
import '../view_model/suspend_order/suspend_order_state.dart';
import '../view_model/unsuspend_order/unsuspend_order_cubit.dart';
import '../view_model/unsuspend_order/unsuspend_order_state.dart';
import 'store_screen.dart';

class StatusUpdateScreen extends StatefulWidget {
  final int orderId;
  final String customerName;
  final String? orderStatus;

  const StatusUpdateScreen({
    super.key,
    required this.orderId,
    required this.customerName,
    this.orderStatus,
  });

  @override
  State<StatusUpdateScreen> createState() => _StatusUpdateScreenState();
}

class _StatusUpdateScreenState extends State<StatusUpdateScreen> {
  int _selectedStatus = 0;
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<CompleteOrderCubit>()),
        BlocProvider(create: (context) => serviceLocator<SuspendOrderCubit>()),
        BlocProvider(create: (context) => serviceLocator<UnsuspendOrderCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CompleteOrderCubit, CompleteOrderState>(
            listener: (context, state) {
              if (state is CompleteOrderSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order completed successfully')),
                );
                Navigator.pop(context, true);
              } else if (state is CompleteOrderFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.apiError?.message.toString() ?? 'Failed to complete order')),
                );
              }
            },
          ),
          BlocListener<SuspendOrderCubit, SuspendOrderState>(
            listener: (context, state) {
              if (state is SuspendOrderSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order suspended successfully')),
                );
                Navigator.pop(context, true);
              } else if (state is SuspendOrderFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.apiError?.message.toString() ?? 'Failed to suspend order')),
                );
              }
            },
          ),
          BlocListener<UnsuspendOrderCubit, UnsuspendOrderState>(
            listener: (context, state) {
              if (state is UnsuspendOrderSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order unsuspended successfully')),
                );
                Navigator.pop(context, true);
              } else if (state is UnsuspendOrderFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.apiError?.message.toString() ?? 'Failed to unsuspend order')),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<CompleteOrderCubit, CompleteOrderState>(
          builder: (context, completeState) {
            return BlocBuilder<SuspendOrderCubit, SuspendOrderState>(
              builder: (context, suspendState) {
                return BlocBuilder<UnsuspendOrderCubit, UnsuspendOrderState>(
                  builder: (context, unsuspendState) {
                    final isLoading = completeState is CompleteOrderLoading ||
                        suspendState is SuspendOrderLoading ||
                        unsuspendState is UnsuspendOrderLoading;
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
                                  'Status update',
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
                                  SingleChildScrollView(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Select the visit result for customer ${widget.customerName}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        if (widget.orderStatus == 'suspended') ...[
                                          _buildStatusCard(
                                            index: 4,
                                            icon: '▶️',
                                            title: 'Unsuspend Order',
                                            description: 'Resume the work on this order.',
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                        _buildStatusCard(
                                          index: 0,
                                          icon: '💰',
                                          title: 'Complete Paid',
                                          description:
                                              'The work is complete and the amount due has been fully collected from the client.',
                                        ),
                                        if (_selectedStatus == 0) ...[
                                          const SizedBox(height: 20),
                                          const Center(
                                            child: Text(
                                              'Amount collected (Omani Rial)',
                                              style: TextStyle(color: Colors.grey, fontSize: 13),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15),
                                              border: Border.all(color: Colors.grey.withOpacity(0.2)),
                                            ),
                                            child: TextField(
                                              controller: _amountController,
                                              keyboardType: TextInputType.number,
                                              decoration: const InputDecoration(
                                                hintText: 'set a price.....',
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                        const SizedBox(height: 20),
                                        _buildStatusCard(
                                          index: 1,
                                          icon: '📝',
                                          title: 'Complete Unpaid',
                                          description:
                                              'The work is completed but the payment has not been collected.',
                                        ),
                                        const SizedBox(height: 20),
                                        _buildStatusCard(
                                          index: 2,
                                          icon: '♻️',
                                          title: 'Complete with resort',
                                          description: 'The work is completed with a resort.',
                                        ),
                                        const SizedBox(height: 20),
                                        _buildStatusCard(
                                          index: 3,
                                          icon: '⏸️',
                                          title: 'Suspend order',
                                          description: 'Temporarily stop the work on this order.',
                                        ),
                                        const SizedBox(height: 24),
                                        const Center(
                                          child: Text(
                                            'Additional notes',
                                            style: TextStyle(color: Colors.grey, fontSize: 13),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(color: Colors.grey.withOpacity(0.2)),
                                          ),
                                          child: TextField(
                                            controller: _notesController,
                                            maxLines: 3,
                                            decoration: const InputDecoration(
                                              hintText: 'Add a note for the admin.....',
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: isLoading
                                                ? null
                                                : () {
                                                    if (_selectedStatus == 0) {
                                                      context.read<CompleteOrderCubit>().completeOrder(
                                                            widget.orderId,
                                                            amount: _amountController.text,
                                                            paymentStatus: 'paid',
                                                            notes: _notesController.text,
                                                          );
                                                    } else if (_selectedStatus == 1) {
                                                      context.read<CompleteOrderCubit>().completeOrder(
                                                            widget.orderId,
                                                            paymentStatus: 'unpaid',
                                                            notes: _notesController.text,
                                                          );
                                                    } else if (_selectedStatus == 2) {
                                                      context.read<CompleteOrderCubit>().completeOrder(
                                                            widget.orderId,
                                                            completionType: 'resort',
                                                            notes: _notesController.text,
                                                          );
                                                    } else if (_selectedStatus == 3) {
                                                      context.read<SuspendOrderCubit>().suspendOrder(
                                                            widget.orderId,
                                                            _notesController.text,
                                                          );
                                                    } else if (_selectedStatus == 4) {
                                                      context.read<UnsuspendOrderCubit>().unsuspendOrder(widget.orderId);
                                                    }
                                                  },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.accentRed,
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
                                                : const Text(
                                                    'Submit the final report ←',
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                  ),
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
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required int index,
    required String icon,
    required String title,
    required String description,
  }) {
    final isSelected = _selectedStatus == index;
    return InkWell(
      onTap: () => setState(() => _selectedStatus = index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColors.accentRed.withOpacity(0.5) : Colors.grey.withOpacity(0.1),
            width: isSelected ? 1 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(icon, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 26),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
