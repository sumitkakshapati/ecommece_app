import 'dart:async';

import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/checkout/cubit/checkout_cubit.dart';
import 'package:ecommerce_app/features/homepage/cubit/add_to_cart_cubit.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalCartAmountCubit extends Cubit<CommonState> {
  ProductRepository repository;
  AddToCartCubit addToCartCubit;
  StreamSubscription? cartSubcription;
  final CheckoutCubit checkoutCubit;
  StreamSubscription? checkoutSubceription;

  TotalCartAmountCubit({
    required this.repository,
    required this.addToCartCubit,
    required this.checkoutCubit,
  }) : super(CommonInitialState()) {
    cartSubcription = addToCartCubit.stream.listen((state) {
      if (state is CommonSuccessState) {
        totalAmount();
      }
    });

    checkoutSubceription = checkoutCubit.stream.listen((state) {
      if (state is CommonSuccessState) {
        totalAmount();
      }
    });
  }

  totalAmount() async {
    emit(CommonLoadingState());
    final _res = await repository.getCartTotalAmount();
    if (_res.status) {
      emit(CommonSuccessState<num>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: "Not Available"));
    }
  }

  @override
  Future<void> close() {
    cartSubcription?.cancel();
    checkoutSubceription?.cancel();
    return super.close();
  }
}
