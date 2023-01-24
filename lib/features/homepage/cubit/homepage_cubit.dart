import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/homepage/cubit/home_page_event.dart';
import 'package:ecommerce_app/features/homepage/model/products.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageCubit extends Bloc<HomepageEvent, CommonState> {
  final ProductRepository repository;
  HomepageCubit({required this.repository}) : super(CommonInitialState()) {
    on<FetchAllHomepageDataEvent>((event, emit) async {
      emit(CommonLoadingState());
      final _res = await repository.getAllProducts(query: event.query);
      if (_res.status) {
        emit(CommonSuccessState<List<Product>>(data: _res.data!));
      } else {
        emit(CommonErrorState(message: _res.message));
      }
    });

    on<ReFetchAllHomepageDataEvent>((event, emit) async {
      emit(CommonLoadingState(isRefreshing: true));
      final _res = await repository.getAllProducts(query: event.query);
      emit(CommonSuccessState<List<Product>>(data: repository.products));
    });

    on<LoadMoreHomepageDataEvent>(
      (event, emit) async {
        emit(CommonLoadingState(isRefreshing: true));
        final _res = await repository.getAllProducts(
            isLoadMore: true, query: event.query);
        emit(CommonSuccessState<List<Product>>(data: repository.products));
      },
      transformer: droppable(),
    );
  }
}
