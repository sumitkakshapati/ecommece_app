import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/homepage/model/products.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageCubit extends Cubit<CommonState> {
  final ProductRepository repository;
  HomepageCubit({required this.repository}) : super(CommonInitialState());

  fetchData() async {
    emit(CommonLoadingState());
    final _res = await repository.getAllProducts();
    if (_res.status) {
      emit(CommonSuccessState<List<Product>>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: _res.message));
    }
  }
}
