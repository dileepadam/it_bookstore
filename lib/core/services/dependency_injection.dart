import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:it_bookstore/core/network/network_info.dart';
import 'package:it_bookstore/features/data/datasources/remote_data_source.dart';
import 'package:it_bookstore/features/data/datasources/remote_data_source_impl.dart';
import 'package:it_bookstore/features/data/repository/repository_impl.dart';
import 'package:it_bookstore/features/domain/repository/repository.dart';
import 'package:it_bookstore/features/domain/usecases/home/get_home_page_data.dart';
import 'package:it_bookstore/features/presentation/bloc/book_details/book_detail_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/home/home_bloc.dart';

import '../../features/domain/usecases/book_details/get_book_details.dart';
import '../../features/domain/usecases/home/search_books_home.dart';
import '../network/api_helper.dart';

final injection = GetIt.instance;

Future<void> setLocator() async {
  injection.registerSingleton(Dio());
  injection.registerLazySingleton<APIHelper>(() => APIHelper(
        dio: injection(),
      ));

  injection.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(apiHelper: injection()));

  injection.registerLazySingleton(() => Connectivity());

  injection
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injection()));

  injection.registerLazySingleton<Repository>(() =>
      RepositoryImpl(remoteDataSource: injection(), networkInfo: injection()));

  //UseCases
  injection
      .registerLazySingleton(() => GetHomePageData(repository: injection()));

  injection
      .registerLazySingleton(() => SearchHomePageData(repository: injection()));

  injection
      .registerLazySingleton(() => GetBookDetails(repository: injection()));

  //bloc
  injection.registerFactory(() => HomePageBloc(
      networkInfo: injection(),
      homePageDataUsecase: injection(),
      searchHomePageDataUseCase: injection()));

  injection.registerFactory(() =>
      BookDetailsBloc(networkInfo: injection(), getBookDetails: injection()));
}
