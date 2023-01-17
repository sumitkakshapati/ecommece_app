import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/auth/resources/user_repository.dart';
import 'package:ecommerce_app/features/splash/model/start_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartUpCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  StartUpCubit({required this.userRepository}) : super(CommonInitialState());

  fetchData() async {
    emit(CommonLoadingState());
    await Future.delayed(Duration(seconds: 2));
    await userRepository.init();
    emit(CommonSuccessState<StartUpData>(
        data: StartUpData(isLoggedIn: userRepository.token.isNotEmpty)));
  }
}
