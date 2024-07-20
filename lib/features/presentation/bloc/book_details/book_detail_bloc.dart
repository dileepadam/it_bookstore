import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/base_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/base_state.dart';
import 'package:it_bookstore/features/presentation/bloc/book_details/book_detail_state.dart';

import '../../../../core/network/network_info.dart';
import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../domain/usecases/book_details/get_book_details.dart';
import 'book_details_event.dart';

class BookDetailsBloc
    extends BaseBloc<BookDetailsEvent, BaseState<BookDetailsState>> {
  final NetworkInfo networkInfo;
  final GetBookDetails getBookDetails;

  BookDetailsBloc({required this.networkInfo, required this.getBookDetails})
      : super(InitBookDetailsState()) {
    on<GetBookDetailsRequestEvent>(_handleGetBookDetailEvent);
  }

  Future<void> _handleGetBookDetailEvent(GetBookDetailsRequestEvent event,
      Emitter<BaseState<BookDetailsState>> emit) async {
    emit(APILoadingState());
    final result = await getBookDetails(event.isbn13!);

    emit(result.fold((l) {
      if (l is ConnectionFailureState) {
        return ConnectionFailureState(
            error: ErrorHandler().mapFailureToMessage(l) ?? "");
      } else if (l is ServerFailure) {
        return ServerFailureState(
            error: ErrorHandler().mapFailureToMessage(l) ?? "");
      } else {
        return GetBookDetailsFailureState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetBookDetailsSuccessState(bookDetailResponse: r);
    }));
  }
}
