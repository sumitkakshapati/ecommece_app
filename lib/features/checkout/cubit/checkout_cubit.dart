import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  CheckoutCubit({required this.productRepository})
      : super(CommonInitialState());

  checkout({
    required String name,
    required String address,
    required String phone,
    required String city,
  }) async {
    emit(CommonLoadingState());
    final _res = await productRepository.checkout(
      name: name,
      address: address,
      phone: phone,
      city: city,
    );
    if (_res.status) {
      emit(CommonSuccessState(data: null));
    } else {
      emit(CommonErrorState(message: _res.message));
    }
  }
}
