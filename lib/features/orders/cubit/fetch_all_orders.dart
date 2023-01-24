import 'dart:async';

import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/checkout/cubit/checkout_cubit.dart';
import 'package:ecommerce_app/features/orders/model/orders.dart';
import 'package:ecommerce_app/features/orders/resources/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchAllOrdersCubit extends Cubit<CommonState> {
  final OrderRepository orderRepository;
  final CheckoutCubit checkoutCubit;
  StreamSubscription? checkoutSubceription;
  FetchAllOrdersCubit({
    required this.orderRepository,
    required this.checkoutCubit,
  }) : super(CommonInitialState()) {
    checkoutSubceription = checkoutCubit.stream.listen((state) {
      if (state is CommonSuccessState) {
        fetchOrders();
      }
    });
  }

  fetchOrders() async {
    emit(CommonLoadingState());
    final _res = await orderRepository.fetchAllOrders();
    if (_res.status) {
      emit(CommonSuccessState<List<Orders>>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: _res.message));
    }
  }

  @override
  Future<void> close() {
    checkoutSubceription?.cancel();
    return super.close();
  }
}
