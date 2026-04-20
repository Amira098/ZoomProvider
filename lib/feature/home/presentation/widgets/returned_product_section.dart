import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/model/products_in_orders.dart';
import '../view_model/products_in_orders/products_in_orders_cubit.dart';
import '../view_model/products_in_orders/products_in_orders_state.dart';
import 'custom_input_field.dart';

class ReturnedProductSection extends StatelessWidget {
  final ProductData? selectedProduct;
  final TextEditingController quantityController;
  final TextEditingController noteController;
  final Function(ProductData?) onProductChanged;
  final String? Function(String?)? quantityValidator;

  const ReturnedProductSection({
    super.key,
    required this.selectedProduct,
    required this.quantityController,
    required this.noteController,
    required this.onProductChanged,
    this.quantityValidator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsInOrdersCubit, ProductsInOrdersState>(
      builder: (context, state) {
        if (state is ProductsInOrdersLoading) {
          return Skeletonizer(
            enabled: true,
            child: _buildFields([
              const ProductData(name: 'Loading...'),
            ]),
          );
        } else if (state is ProductsInOrdersSuccess) {
          return _buildFields(state.productsInOrders.data ?? []);
        } else if (state is ProductsInOrdersFailure) {
          return Center(
            child: Text(
              state.apiError?.getLocalizedMessage(context) ??
                  LocaleKeys.status_update_error_loading_products.tr(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildFields(List<ProductData> products) {
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
              value: selectedProduct,
              hint: Text(LocaleKeys.status_update_select_product.tr()),
              items: products.map((ProductData product) {
                return DropdownMenuItem<ProductData>(
                  value: product,
                  child: Text(product.name ?? ''),
                );
              }).toList(),
              onChanged: onProductChanged,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        CustomInputField(
          controller: quantityController,
          hintText: LocaleKeys.status_update_quantity.tr(),
          keyboardType: TextInputType.number,
          validator: quantityValidator,
        ),
        SizedBox(height: 16.h),
        CustomInputField(
          controller: noteController,
          hintText: LocaleKeys.status_update_product_note.tr(),
          maxLines: 2,
        ),
      ],
    );
  }
}
