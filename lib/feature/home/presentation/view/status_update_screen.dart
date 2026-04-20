import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zoom_provider/generated/locale_keys.g.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/show_pretty_snack.dart';
import '../../../app_section/presentation/view/app_section.dart';
import '../../data/model/products_in_orders.dart';
import '../view_model/complete_order/complete_order_cubit.dart';
import '../view_model/complete_order/complete_order_state.dart';
import '../view_model/completed_paid/completed_paid_cubit.dart';
import '../view_model/completed_paid/completed_paid_state.dart';
import '../view_model/products_in_orders/products_in_orders_cubit.dart';
import '../view_model/products_in_orders/products_in_orders_state.dart';
import '../view_model/suspend_order/suspend_order_cubit.dart';
import '../view_model/suspend_order/suspend_order_state.dart';
import '../view_model/suspend_with_goods_returned/suspend_with_goods_returned_cubit.dart';
import '../view_model/suspend_with_goods_returned/suspend_with_goods_returned_state.dart';
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
  final ImagePicker _picker = ImagePicker();

  int _selectedStatus = 0;

  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _materialsController = TextEditingController();
  final TextEditingController _productQuantityController =
  TextEditingController();
  final TextEditingController _productNoteController = TextEditingController();

  ProductData? _selectedProduct;
  XFile? _depositReceipt;
  String? _selectedDepositAccountType;

  static const List<Map<String, String>> _depositAccountOptions = [
    {
      'label': 'تم التحويل على حساب الشركة',
      'value': 'company_transfer',
    },
    {
      'label': 'تم التحويل على حساب الحج مصطفى',
      'value': 'employee_transfer',
    },
    {
      'label': 'اخذ النقود كاش',
      'value': 'cash',
    },
  ];

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
    _productQuantityController.dispose();
    _productNoteController.dispose();
    super.dispose();
  }

  void _showMessage(String message, {bool isError = false}) {
    showPrettySnack(context, message, success: !isError);
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

  Future<void> _pickDepositReceipt() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _depositReceipt = pickedFile;
        });
      }
    } catch (e) {
      _showMessage(e.toString(), isError: true);
    }
  }

  void _resetConditionalFields() {
    _notesController.clear();
    _amountController.clear();
    _materialsController.clear();
    _productQuantityController.clear();
    _productNoteController.clear();

    _selectedProduct = null;
    _depositReceipt = null;
    _selectedDepositAccountType = null;
  }

  void _onStatusSelected(int index) {
    setState(() {
      _selectedStatus = index;
      _resetConditionalFields();
    });

    if (_isGoodsReturned) {
      context.read<ProductsInOrdersCubit>().getProductsInOrders(widget.orderId);
    }

    _formKey.currentState?.validate();
  }

  String? _validateAmount(String? value) {
    if (!_isCompletedWithPayment) return null;

    final amountText = value?.trim() ?? '';
    if (amountText.isEmpty) {
      return LocaleKeys.status_update_error_amount_empty.tr();
    }

    final amount = _parseDouble(amountText);
    if (amount == null || amount <= 0) {
      return LocaleKeys.status_update_error_amount_invalid.tr();
    }

    return null;
  }

  String? _validateMaterials(String? value) {
    if (!_isCompletedWithPayment) return null;

    final materialsText = value?.trim() ?? '';
    if (materialsText.isEmpty) return null;

    final materials = _parseDouble(materialsText);
    if (materials == null || materials < 0) {
      return LocaleKeys.status_update_error_materials_invalid.tr();
    }

    return null;
  }

  String? _validateNotes(String? value) {
    if (!_isNotesRequired) return null;

    final note = value?.trim() ?? '';
    if (note.isEmpty) {
      return LocaleKeys.status_update_error_note_required.tr();
    }

    return null;
  }

  String? _validateReturnedQuantity(String? value) {
    if (!_isGoodsReturned) return null;

    final quantityText = value?.trim() ?? '';
    if (quantityText.isEmpty) {
      return LocaleKeys.status_update_error_enter_quantity.tr();
    }

    final quantity = int.tryParse(quantityText);
    if (quantity == null || quantity <= 0) {
      return LocaleKeys.status_update_error_enter_quantity.tr();
    }

    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      _showMessage(
        LocaleKeys.status_update_error_review_fields.tr(),
        isError: true,
      );
      return;
    }

    if (_isCompletedWithPayment) {
      if (widget.servicesIds.isEmpty) {
        _showMessage(
          LocaleKeys.status_update_error_services_empty.tr(),
          isError: true,
        );
        return;
      }

      if (_selectedDepositAccountType == null) {
        _showMessage('Please select deposit account type', isError: true);
        return;
      }

      if (_depositReceipt == null) {
        _showMessage('Please upload deposit receipt', isError: true);
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
        depositReceipt: _depositReceipt!,
        depositAccountType: _selectedDepositAccountType!,
      );
      return;
    }

    if (_isCompletedWithoutPayment) {
      context.read<CompleteOrderCubit>().completeOrder(widget.orderId);
      return;
    }

    if (_isGoodsLeftWithCustomer) {
      context.read<SuspendOrderCubit>().suspendOrder(
        widget.orderId,
        _notesController.text.trim(),
      );
      return;
    }

    if (_isGoodsReturned) {
      if (_selectedProduct == null) {
        _showMessage(
          LocaleKeys.status_update_error_select_product.tr(),
          isError: true,
        );
        return;
      }

      final quantity = int.tryParse(_productQuantityController.text.trim());
      if (quantity == null || quantity <= 0) {
        _showMessage(
          LocaleKeys.status_update_error_enter_quantity.tr(),
          isError: true,
        );
        return;
      }

      final formData = FormData.fromMap({
        'products[0][id]': _selectedProduct!.productId,
        'products[0][quantity]': quantity,
        'notes': _productNoteController.text.trim(),
      });

      context
          .read<SuspendWithGoodsReturnedCubit>()
          .suspendWithGoodsReturned(widget.orderId, formData);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CompleteOrderCubit, CompleteOrderState>(
          listener: (context, state) {
            if (state is CompleteOrderSuccess) {
              _showMessage(LocaleKeys.status_update_success_complete.tr());
              _navigateToMainLayout();
            } else if (state is CompleteOrderFailure) {
              _showMessage(
                state.apiError?.getLocalizedMessage(context) ??
                    LocaleKeys.status_update_failed_complete.tr(),
                isError: true,
              );
            }
          },
        ),
        BlocListener<SuspendOrderCubit, SuspendOrderState>(
          listener: (context, state) {
            if (state is SuspendOrderSuccess) {
              _showMessage(LocaleKeys.status_update_success_suspend.tr());
              _navigateToMainLayout();
            } else if (state is SuspendOrderFailure) {
              _showMessage(
                state.apiError?.getLocalizedMessage(context) ??
                    LocaleKeys.status_update_failed_suspend.tr(),
                isError: true,
              );
            }
          },
        ),
        BlocListener<CompletedPaidCubit, CompletedPaidState>(
          listener: (context, state) {
            if (state is CompletedPaidSuccess) {
              final successMessage = state.data.getLocalizedMessage(context);
              _showMessage(successMessage);
              _navigateToMainLayout();
            } else if (state is CompletedPaidFailure) {
              _showMessage(state.message, isError: true);
            }
          },
        ),
        BlocListener<SuspendWithGoodsReturnedCubit,
            SuspendWithGoodsReturnedState>(
          listener: (context, state) {
            if (state is SuspendWithGoodsReturnedSuccess) {
              _showMessage(LocaleKeys.status_update_success_suspend.tr());
              _navigateToMainLayout();
            } else if (state is SuspendWithGoodsReturnedFailure) {
              _showMessage(
                state.apiError?.getLocalizedMessage(context) ??
                    LocaleKeys.status_update_failed_suspend.tr(),
                isError: true,
              );
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
                  return BlocBuilder<SuspendWithGoodsReturnedCubit,
                      SuspendWithGoodsReturnedState>(
                    builder: (context, suspendWithGoodsReturnedState) {
                      final isLoading =
                          completeState is CompleteOrderLoading ||
                              suspendState is SuspendOrderLoading ||
                              completedPaidState is CompletedPaidLoading ||
                              suspendWithGoodsReturnedState
                              is SuspendWithGoodsReturnedLoading;

                      return Scaffold(
                        backgroundColor: AppColors.surface,
                        body: SafeArea(
                          bottom: false,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
                                    Expanded(
                                      child: Text(
                                        LocaleKeys.status_update_title.tr(),
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
                                            builder: (_) =>
                                            const StoreScreen(),
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
                                                LocaleKeys
                                                    .status_update_select_result
                                                    .tr(args: [
                                                  widget.customerName
                                                ]),
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
                                              title: LocaleKeys
                                                  .status_update_completed_paid
                                                  .tr(),
                                              description: '',
                                            ),

                                            if (_isCompletedWithPayment) ...[
                                              const SizedBox(height: 20),
                                              Center(
                                                child: Text(
                                                  LocaleKeys
                                                      .status_update_amount_collected
                                                      .tr(),
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              _buildInputField(
                                                controller: _amountController,
                                                hintText: LocaleKeys
                                                    .status_update_set_amount
                                                    .tr(),
                                                keyboardType:
                                                const TextInputType
                                                    .numberWithOptions(
                                                  decimal: true,
                                                ),
                                                validator: _validateAmount,
                                              ),
                                              const SizedBox(height: 16),
                                              Center(
                                                child: Text(
                                                  LocaleKeys
                                                      .status_update_materials_amount
                                                      .tr(),
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              _buildInputField(
                                                controller:
                                                _materialsController,
                                                hintText: LocaleKeys
                                                    .status_update_set_materials_amount
                                                    .tr(),
                                                keyboardType:
                                                const TextInputType
                                                    .numberWithOptions(
                                                  decimal: true,
                                                ),
                                                validator: _validateMaterials,
                                              ),
                                              const SizedBox(height: 16),
                                              _buildDepositAccountTypeDropdown(),
                                              const SizedBox(height: 16),
                                              _buildReceiptPicker(),
                                            ],

                                            const SizedBox(height: 20),

                                            _buildStatusCard(
                                              index: 1,
                                              icon: '🔧',
                                              title: LocaleKeys
                                                  .status_update_completed_unpaid
                                                  .tr(),
                                              description: LocaleKeys
                                                  .status_update_completed_unpaid_desc
                                                  .tr(),
                                            ),

                                            const SizedBox(height: 20),

                                            _buildStatusCard(
                                              index: 2,
                                              icon: '📦',
                                              title: LocaleKeys
                                                  .status_update_suspended_left
                                                  .tr(),
                                              description: LocaleKeys
                                                  .status_update_suspended_left_desc
                                                  .tr(),
                                            ),

                                            const SizedBox(height: 20),

                                            _buildStatusCard(
                                              index: 3,
                                              icon: '↩️',
                                              title: LocaleKeys
                                                  .status_update_suspended_returned
                                                  .tr(),
                                              description: LocaleKeys
                                                  .status_update_suspended_returned_desc
                                                  .tr(),
                                            ),

                                            if (_isGoodsReturned) ...[
                                              SizedBox(height: 20.h),
                                              BlocBuilder<ProductsInOrdersCubit,
                                                  ProductsInOrdersState>(
                                                builder: (context, state) {
                                                  if (state
                                                  is ProductsInOrdersLoading) {
                                                    return Skeletonizer(
                                                      enabled: true,
                                                      child:
                                                      _buildProductFields(
                                                        [
                                                          const ProductData(
                                                            name: 'Loading...',
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } else if (state
                                                  is ProductsInOrdersSuccess) {
                                                    return _buildProductFields(
                                                      state.productsInOrders
                                                          .data ??
                                                          [],
                                                    );
                                                  } else if (state
                                                  is ProductsInOrdersFailure) {
                                                    return Center(
                                                      child: Text(
                                                        state.apiError
                                                            ?.getLocalizedMessage(
                                                            context) ??
                                                            'Error loading products',
                                                      ),
                                                    );
                                                  }
                                                  return const SizedBox.shrink();
                                                },
                                              ),
                                            ],

                                            const SizedBox(height: 24),

                                            Center(
                                              child: RichText(
                                                text: TextSpan(
                                                  text: LocaleKeys
                                                      .status_update_additional_notes
                                                      .tr(),
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
                                                  ? LocaleKeys
                                                  .status_update_add_note_required
                                                  .tr()
                                                  : LocaleKeys
                                                  .status_update_add_note
                                                  .tr(),
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 16,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20),
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
                                                    : Text(
                                                  LocaleKeys
                                                      .status_update_submit
                                                      .tr(),
                                                  style: const TextStyle(
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
          );
        },
      ),
    );
  }

  Widget _buildReceiptPicker() {
    final hasReceipt = _depositReceipt != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Deposit receipt',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: _pickDepositReceipt,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: hasReceipt
                    ? AppColors.accentRed.withOpacity(0.5)
                    : Colors.grey.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  hasReceipt ? Icons.check_circle : Icons.upload_file,
                  color: hasReceipt ? Colors.green : AppColors.accentRed,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    hasReceipt
                        ? _depositReceipt!.name
                        : 'Upload deposit receipt',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight:
                      hasReceipt ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
                if (hasReceipt)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _depositReceipt = null;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductFields(List<ProductData> products) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ProductData>(
              isExpanded: true,
              value: _selectedProduct,
              hint: Text(LocaleKeys.status_update_select_product.tr()),
              items: products.map((ProductData product) {
                return DropdownMenuItem<ProductData>(
                  value: product,
                  child: Text(product.name ?? ''),
                );
              }).toList(),
              onChanged: (ProductData? newValue) {
                setState(() {
                  _selectedProduct = newValue;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          controller: _productQuantityController,
          hintText: LocaleKeys.status_update_quantity.tr(),
          keyboardType: TextInputType.number,
          validator: _validateReturnedQuantity,
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          controller: _productNoteController,
          hintText: LocaleKeys.status_update_product_note.tr(),
          maxLines: 2,
        ),
      ],
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
      style: TextStyle(color: AppColors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        counterStyle: TextStyle(color: AppColors.black),
        helperStyle: TextStyle(color: AppColors.black),
        labelStyle: TextStyle(color: AppColors.black),
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

  Widget _buildDepositAccountTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'نوع التحويل',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedDepositAccountType,
              hint: const Text('اختر نوع التحويل',style: TextStyle(fontSize: 15),),
              items: _depositAccountOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option['value'],
                  child: Text(option['label']!,style: TextStyle(fontSize: 15),),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDepositAccountType = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}