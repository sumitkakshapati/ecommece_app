import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/homepage/model/products.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailCubit extends Cubit<CommonState> {
  final ProductRepository repository;
  ProductDetailCubit({required this.repository}) : super(CommonInitialState());

  fetchProductDetails(String productId) async {
    emit(CommonLoadingState());
    final _res = await repository.getProductDetails(productId);
    if (_res.status) {
      emit(CommonSuccessState<Product>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: _res.message));
    }
  }
}
