import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/auth/resources/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  RegisterCubit({required this.userRepository}) : super(CommonInitialState());

  register({
    required String fullName,
    required String address,
    required String password,
    required String email,
    required String phone,
  }) async {
    emit(CommonLoadingState());
    final _res = await userRepository.signUp(
      fullName: fullName,
      address: address,
      password: password,
      email: email,
      phone: phone,
    );
    if (_res.status) {
      emit(CommonSuccessState(data: null));
    } else {
      emit(CommonErrorState(message: _res.message));
    }
  }
}
