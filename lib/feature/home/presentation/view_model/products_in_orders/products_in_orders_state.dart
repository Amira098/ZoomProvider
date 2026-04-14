import '../../../../../core/models/api_error.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/model/products_in_orders.dart';

abstract class ProductsInOrdersState {}

class ProductsInOrdersInitial extends ProductsInOrdersState {}

class ProductsInOrdersLoading extends ProductsInOrdersState {}

class ProductsInOrdersSuccess extends ProductsInOrdersState {
  final ProductsInOrders productsInOrders;

  ProductsInOrdersSuccess({required this.productsInOrders});
}

class ProductsInOrdersFailure extends ProductsInOrdersState {
  final ApiError? apiError;
  final Exception? exception;

  ProductsInOrdersFailure({this.apiError, this.exception});
}