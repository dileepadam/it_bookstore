import 'package:it_bookstore/features/data/models/common/base_response.dart';
import 'package:it_bookstore/features/presentation/bloc/base_state.dart';

abstract class HomeState extends BaseState<HomeState> {}

class InitHomeState extends HomeState {}

class GetHomeDataSuccessState extends HomeState {
  final BaseResponse? response;

  GetHomeDataSuccessState({this.response});
}

class GetHomeDataFailureState extends HomeState {
  String? message;

  GetHomeDataFailureState({this.message});
}
