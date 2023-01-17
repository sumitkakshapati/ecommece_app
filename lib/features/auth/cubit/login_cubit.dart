import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/auth/model/user.dart';
import 'package:ecommerce_app/features/auth/resources/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  LoginCubit({required this.userRepository}) : super(CommonInitialState());

  login({required String email, required String password}) async {
    emit(CommonLoadingState());
    final _res = await userRepository.login(email: email, password: password);
    if (_res.status) {
      emit(CommonSuccessState<User>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: _res.message));
    }
  }
}
