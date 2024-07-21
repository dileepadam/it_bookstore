import 'package:it_bookstore/features/presentation/bloc/base_event.dart';

import '../../../data/models/common/base_response.dart';

abstract class HomeEvent extends BaseEvent {}

class GetHomeDataRequestEvent extends HomeEvent {}

class SearchHomeDataRequestEvent extends HomeEvent {
  String? bookName;

  SearchHomeDataRequestEvent({this.bookName});
}

class GetFavoriteBooksEvent extends HomeEvent {}

class StoreFavoriteBookEvent extends HomeEvent {
  List<Book>? books;

  StoreFavoriteBookEvent({this.books});
}
