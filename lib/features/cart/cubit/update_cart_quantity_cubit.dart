import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/homepage/model/cart.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCartQuantityCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  UpdateCartQuantityCubit({required this.productRepository})
      : super(CommonInitialState());

  updateQuantity({required String cartId, required int quantity}) async {
    emit(CommonLoadingState());
    final _res =
        await productRepository.updateCartItemQuantity(cartId, quantity);
    if (_res.status) {
      emit(CommonSuccessState<CartModel>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: _res.message));
    }
  }
}
