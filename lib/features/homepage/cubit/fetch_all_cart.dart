import 'dart:async';

import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/checkout/cubit/checkout_cubit.dart';
import 'package:ecommerce_app/features/homepage/cubit/add_to_cart_cubit.dart';
import 'package:ecommerce_app/features/homepage/model/cart.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchAllCartCubit extends Cubit<CommonState> {
  final ProductRepository repository;
  final AddToCartCubit addToCartCubit;
  StreamSubscription? addToCartSubceription;
  final CheckoutCubit checkoutCubit;
  StreamSubscription? checkoutSubceription;

  FetchAllCartCubit({
    required this.repository,
    required this.addToCartCubit,
    required this.checkoutCubit,
  }) : super(CommonInitialState()) {
    addToCartSubceription = addToCartCubit.stream.listen((state) {
      if (state is CommonSuccessState) {
        fetchData();
      }
    });

    checkoutSubceription = checkoutCubit.stream.listen((state) {
      if (state is CommonSuccessState) {
        fetchData();
      }
    });
  }

  fetchData() async {
    emit(CommonLoadingState());
    final _res = await repository.getAllCartProducts();
    if (_res.status) {
      emit(CommonSuccessState<List<CartModel>>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: _res.message));
    }
  }

  @override
  Future<void> close() {
    addToCartSubceription?.cancel();
    checkoutSubceription?.cancel();
    return super.close();
  }
}
