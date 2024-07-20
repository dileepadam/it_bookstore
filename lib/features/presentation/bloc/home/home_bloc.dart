import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/base_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/base_state.dart';
import 'package:it_bookstore/features/presentation/bloc/home/home_event.dart';
import 'package:it_bookstore/features/presentation/bloc/home/home_state.dart';

import '../../../../core/network/network_info.dart';
import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../domain/usecases/home/get_home_page_data.dart';
import '../../../domain/usecases/home/search_books_home.dart';

class HomePageBloc extends BaseBloc<HomeEvent, BaseState<HomeState>> {
  final NetworkInfo networkInfo;
  final GetHomePageData homePageDataUsecase;
  final SearchHomePageData searchHomePageDataUseCase;

  HomePageBloc(
      {required this.searchHomePageDataUseCase,
      required this.networkInfo,
      required this.homePageDataUsecase})
      : super(InitHomeState()) {
    on<GetHomeDataRequestEvent>(_handleGetHomeDataEvent);
    on<SearchHomeDataRequestEvent>(_handleSearchHomeDataEvent);
  }

  Future<void> _handleGetHomeDataEvent(
      GetHomeDataRequestEvent event, Emitter<BaseState<HomeState>> emit) async {
    emit(APILoadingState());
    final result = await homePageDataUsecase(const Params());

    emit(result.fold((l) {
      if (l is ConnectionFailureState) {
        return ConnectionFailureState(
            error: ErrorHandler().mapFailureToMessage(l) ?? "");
      } else if (l is ServerFailure) {
        return ServerFailureState(
            error: ErrorHandler().mapFailureToMessage(l) ?? "");
      } else {
        return GetHomeDataFailureState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return GetHomeDataSuccessState(response: r);
    }));
  }

  Future<void> _handleSearchHomeDataEvent(SearchHomeDataRequestEvent event,
      Emitter<BaseState<HomeState>> emit) async {
    final result = await searchHomePageDataUseCase(event.bookName!);

    emit(result.fold((l) {
      if (l is ConnectionFailureState) {
        return ConnectionFailureState(
            error: ErrorHandler().mapFailureToMessage(l) ?? "");
      } else if (l is ServerFailure) {
        return ServerFailureState(
            error: ErrorHandler().mapFailureToMessage(l) ?? "");
      } else {
        return SearchHomeDataFailureState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return SearchHomeDataSuccessState(response: r);
    }));
  }
}
