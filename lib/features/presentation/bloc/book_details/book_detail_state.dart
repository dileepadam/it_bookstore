import 'package:it_bookstore/features/data/models/responses/book_detail_response.dart';
import 'package:it_bookstore/features/presentation/bloc/base_state.dart';

abstract class BookDetailsState extends BaseState<BookDetailsState> {}

class InitBookDetailsState extends BookDetailsState {}

class GetBookDetailsSuccessState extends BookDetailsState {
  final BookDetailResponse? bookDetailResponse;

  GetBookDetailsSuccessState({this.bookDetailResponse});
}

class GetBookDetailsFailureState extends BookDetailsState {
  final String? message;

  GetBookDetailsFailureState({this.message});
}
