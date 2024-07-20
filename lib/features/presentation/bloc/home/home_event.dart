import 'package:it_bookstore/features/presentation/bloc/base_event.dart';

abstract class HomeEvent extends BaseEvent {}

class GetHomeDataRequestEvent extends HomeEvent {}

class SearchHomeDataRequestEvent extends HomeEvent {
  String? bookName;

  SearchHomeDataRequestEvent({this.bookName});
}
