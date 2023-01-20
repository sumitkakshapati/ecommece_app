import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartCubit extends Cubit<CommonState> {
  final ProductRepository repository;
  AddToCartCubit({required this.repository}) : super(CommonInitialState());

  addToCart(String productId) async {
    emit(CommonLoadingState());
    final _res = await repository.addToCart(productId);
    if (_res.status) {
      emit(CommonSuccessState(data: null));
    } else {
      emit(CommonErrorState(message: _res.message));
    }
  }
}
