abstract class CommonState {}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {
  final bool isRefreshing;

  CommonLoadingState({this.isRefreshing = false});
}

class CommonSuccessState<T> extends CommonState {
  final T data;
  CommonSuccessState({
    required this.data,
  });
}

class CommonErrorState extends CommonState {
  final String message;
  CommonErrorState({
    required this.message,
  });
}
