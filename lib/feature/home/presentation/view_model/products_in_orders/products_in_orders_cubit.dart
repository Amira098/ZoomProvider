import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../data/data_sources/home_data_sources.dart';
import '../../../data/model/products_in_orders.dart';
import 'products_in_orders_state.dart';

@injectable
class ProductsInOrdersCubit extends Cubit<ProductsInOrdersState> {
  final HomeDataSources homeRepo;

  ProductsInOrdersCubit({required this.homeRepo}) : super(ProductsInOrdersInitial());

  Future<void> getProductsInOrders(int orderId) async {
    emit(ProductsInOrdersLoading());

    final result = await homeRepo.productsInOrders(orderId);

    switch (result) {
      case SuccessResult<ProductsInOrders>():
        emit(ProductsInOrdersSuccess(productsInOrders: result.data));
        break;

      case FailureResult<ProductsInOrders>():
        emit(
          ProductsInOrdersFailure(
            apiError: result.apiError,
            exception: result.exception,
          ),
        );
        break;
    }
  }
}
