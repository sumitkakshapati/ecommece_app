import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalCartAmountCubit extends Cubit<CommonState> {
  ProductRepository repository;

  TotalCartAmountCubit({required this.repository})
      : super(CommonInitialState());

  totalAmount() async {
    emit(CommonLoadingState());
    final _res = await repository.getCartTotalAmount();
    if (_res.status) {
      emit(CommonSuccessState<num>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: "Not Available"));
    }
  }
}
