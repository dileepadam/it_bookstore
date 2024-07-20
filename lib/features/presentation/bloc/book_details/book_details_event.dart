import 'package:it_bookstore/features/presentation/bloc/base_event.dart';

abstract class BookDetailsEvent extends BaseEvent {}

class GetBookDetailsRequestEvent extends BookDetailsEvent {
  final String? isbn13;

  GetBookDetailsRequestEvent({this.isbn13});
}
