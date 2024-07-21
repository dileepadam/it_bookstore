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

class SearchHomeDataSuccessState extends HomeState {
  final BaseResponse? response;

  SearchHomeDataSuccessState({this.response});
}

class SearchHomeDataFailureState extends HomeState {
  String? message;

  SearchHomeDataFailureState({this.message});
}

class GetFavoriteBooksSuccessState extends HomeState {
  final List<Book>? books;

  GetFavoriteBooksSuccessState({this.books});
}

class GetFavoriteBooksFailureState extends HomeState {
  final String? message;

  GetFavoriteBooksFailureState({this.message});
}

class StoreFavoriteBooksSuccessState extends HomeState {
  final bool? isSuccess;

  StoreFavoriteBooksSuccessState({this.isSuccess});
}

class StoreFavoriteBooksFailureState extends HomeState {
  final String? message;

  StoreFavoriteBooksFailureState({this.message});
}
