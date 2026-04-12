import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../app_section/presentation/view/app_section.dart';
import '../view_model/complete_order/complete_order_cubit.dart';
import '../view_model/complete_order/complete_order_state.dart';
import '../view_model/completed_paid/completed_paid_cubit.dart';
import '../view_model/completed_paid/completed_paid_state.dart';
import '../view_model/suspend_order/suspend_order_cubit.dart';
import '../view_model/suspend_order/suspend_order_state.dart';
import 'store_screen.dart';

class StatusUpdateScreen extends StatefulWidget {
  final int orderId;
  final String customerName;
  final List<int> servicesIds;

  const StatusUpdateScreen({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.servicesIds,
  });

  @override
  State<StatusUpdateScreen> createState() => _StatusUpdateScreenState();
}

class _StatusUpdateScreenState extends State<StatusUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  int _selectedStatus = 0;

  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _materialsController = TextEditingController();

  bool get _isCompletedWithPayment => _selectedStatus == 0;
  bool get _isCompletedWithoutPayment => _selectedStatus == 1;
  bool get _isGoodsLeftWithCustomer => _selectedStatus == 2;
  bool get _isGoodsReturned => _selectedStatus == 3;

  bool get _isNotesRequired => _isGoodsLeftWithCustomer;

  @override
  void dispose() {
    _notesController.dispose();
    _amountController.dispose();
    _materialsController.dispose();
    super.dispose();
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _navigateToMainLayout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainLayout()),
          (route) => false,
    );
  }

  double? _parseDouble(String value) {
    final normalized = value.trim().replaceAll(',', '.');
    return double.tryParse(normalized);
  }

  void _onStatusSelected(int index) {
    setState(() {
      _selectedStatus = index;
    });
    _formKey.currentState?.validate();
  }

  String? _validateAmount(String? value) {
    if (!_isCompletedWithPayment) return null;

    final amountText = value?.trim() ?? '';
    if (amountText.isEmpty) {
      return 'Amount is required';
    }

    final amount = _parseDouble(amountText);
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }

    return null;
  }

  String? _validateMaterials(String? value) {
    if (!_isCompletedWithPayment) return null;

    final materialsText = value?.trim() ?? '';
    if (materialsText.isEmpty) return null;

    final materials = _parseDouble(materialsText);
    if (materials == null) {
      return 'Please enter a valid materials amount';
    }

    return null;
  }

  String? _validateNotes(String? value) {
    if (!_isNotesRequired) return null;

    final note = value?.trim() ?? '';
    if (note.isEmpty) {
      return 'Note is required for this status';
    }

    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      _showMessage('Please review the required fields', isError: true);
      return;
    }

    if (_isCompletedWithPayment) {
      if (widget.servicesIds.isEmpty) {
        _showMessage('Services list is empty', isError: true);
        return;
      }

      final amount = _parseDouble(_amountController.text.trim())!;
      final materialsText = _materialsController.text.trim();
      final materials =
      materialsText.isEmpty ? null : _parseDouble(materialsText);

      context.read<CompletedPaidCubit>().completedPaid(
        orderId: widget.orderId,
        amount: amount,
        servicesIds: widget.servicesIds,
        materials: materials,
      );
      return;
    }

    if (_isCompletedWithoutPayment) {
      context.read<CompleteOrderCubit>().completeOrder(widget.orderId);
      return;
    }

    if (_isGoodsLeftWithCustomer || _isGoodsReturned) {
      context.read<SuspendOrderCubit>().suspendOrder(
        widget.orderId,
        _notesController.text.trim(),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<CompleteOrderCubit>()),
        BlocProvider(create: (_) => serviceLocator<SuspendOrderCubit>()),
        BlocProvider(create: (_) => serviceLocator<CompletedPaidCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CompleteOrderCubit, CompleteOrderState>(
            listener: (context, state) {
              if (state is CompleteOrderSuccess) {
                _showMessage('Order completed successfully');
                _navigateToMainLayout();
              } else if (state is CompleteOrderFailure) {
                _showMessage(
                  state.apiError?.message.toString() ??
                      'Failed to complete order',
                  isError: true,
                );
              }
            },
          ),
          BlocListener<SuspendOrderCubit, SuspendOrderState>(
            listener: (context, state) {
              if (state is SuspendOrderSuccess) {
                _showMessage('Order suspended successfully');
                _navigateToMainLayout();
              } else if (state is SuspendOrderFailure) {
                _showMessage(
                  state.apiError?.message.toString() ??
                      'Failed to suspend order',
                  isError: true,
                );
              }
            },
          ),
          BlocListener<CompletedPaidCubit, CompletedPaidState>(
            listener: (context, state) {
              if (state is CompletedPaidSuccess) {
                final successMessage =
                    state.data.message?.toString() ?? 'Payment request sent';
                _showMessage(successMessage);
                _navigateToMainLayout();
              } else if (state is CompletedPaidFailure) {
                _showMessage(state.message, isError: true);
              }
            },
          ),
        ],
        child: BlocBuilder<CompleteOrderCubit, CompleteOrderState>(
          builder: (context, completeState) {
            return BlocBuilder<SuspendOrderCubit, SuspendOrderState>(
              builder: (context, suspendState) {
                return BlocBuilder<CompletedPaidCubit, CompletedPaidState>(
                  builder: (context, completedPaidState) {
                    final isLoading =
                        completeState is CompleteOrderLoading ||
                            suspendState is SuspendOrderLoading ||
                            completedPaidState is CompletedPaidLoading;

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
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
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
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.all(20),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

                                          _buildStatusCard(
                                            index: 0,
                                            icon: '✅',
                                            title:
                                            'Installation completed and payment received from the customer',
                                            description: '',
                                          ),

                                          if (_isCompletedWithPayment) ...[
                                            const SizedBox(height: 20),
                                            const Center(
                                              child: Text(
                                                'Amount collected (Omani Rial)',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            _buildInputField(
                                              controller: _amountController,
                                              hintText: 'Set amount...',
                                              keyboardType:
                                              const TextInputType.numberWithOptions(
                                                decimal: true,
                                              ),
                                              validator: _validateAmount,
                                            ),
                                            const SizedBox(height: 16),
                                            const Center(
                                              child: Text(
                                                'Materials amount (optional)',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            _buildInputField(
                                              controller: _materialsController,
                                              hintText:
                                              'Set materials amount...',
                                              keyboardType:
                                              const TextInputType.numberWithOptions(
                                                decimal: true,
                                              ),
                                              validator: _validateMaterials,
                                            ),
                                          ],

                                          const SizedBox(height: 20),

                                          _buildStatusCard(
                                            index: 1,
                                            icon: '🔧',
                                            title:
                                            'Installation completed, no payment received',
                                            description:
                                            'The work is completed but the payment has not been collected — an alert will be sent to the Accounts',
                                          ),

                                          const SizedBox(height: 20),

                                          _buildStatusCard(
                                            index: 2,
                                            icon: '📦',
                                            title:
                                            'Installation was not completed and the goods were left with the customer.',
                                            description:
                                            'A note is required in this case to explain the reason clearly.',
                                          ),

                                          const SizedBox(height: 20),

                                          _buildStatusCard(
                                            index: 3,
                                            icon: '↩️',
                                            title:
                                            'The installation was not completed and the goods were returned by the customer.',
                                            description:
                                            'The work was not completed and all the goods were retrieved from the customer and returned.',
                                          ),

                                          const SizedBox(height: 24),

                                          Center(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Additional notes',
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                children: [
                                                  if (_isNotesRequired)
                                                    const TextSpan(
                                                      text: ' *',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          _buildInputField(
                                            controller: _notesController,
                                            hintText: _isNotesRequired
                                                ? 'Add a required note for the admin...'
                                                : 'Add a note for the admin...',
                                            maxLines: 3,
                                            validator: _validateNotes,
                                          ),

                                          const SizedBox(height: 24),

                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed:
                                              isLoading ? null : _submit,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                AppColors.accentRed,
                                                foregroundColor: Colors.white,
                                                disabledBackgroundColor:
                                                AppColors.accentRed
                                                    .withOpacity(0.6),
                                                padding:
                                                const EdgeInsets.symmetric(
                                                  vertical: 16,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                                elevation: 0,
                                              ),
                                              child: isLoading
                                                  ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                                  : const Text(
                                                'Submit the final report ←',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 40),
                                        ],
                                      ),
                                    ),
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.accentRed.withOpacity(0.6),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
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
      borderRadius: BorderRadius.circular(30),
      onTap: () => _onStatusSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected
                ? AppColors.accentRed.withOpacity(0.6)
                : Colors.grey.withOpacity(0.12),
            width: isSelected ? 1.4 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.accentRed.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
              : [],
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
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
            if (description.trim().isNotEmpty) ...[
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
          ],
        ),
      ),
    );
  }
}