import 'package:fpdart/src/either.dart';
import 'package:it_bookstore/error/exceptions.dart';
import 'package:it_bookstore/error/failures.dart';
import 'package:it_bookstore/features/data/datasources/local_data_source.dart';
import 'package:it_bookstore/features/data/datasources/remote_data_source.dart';
import 'package:it_bookstore/features/data/models/common/base_response.dart';
import 'package:it_bookstore/features/data/models/responses/book_detail_response.dart';
import 'package:it_bookstore/features/domain/repository/repository.dart';

import '../../../core/network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource? remoteDataSource;
  final LocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  RepositoryImpl(
      {required this.remoteDataSource,
      required this.networkInfo,
      required this.localDataSource});

  @override
  Future<Either<Failure, BaseResponse>> getNewBooks() async {
    if (await networkInfo!.isConnected) {
      try {
        final parm = await remoteDataSource!.getNewBooks();
        return Right(parm);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> searchBooks(String bookName) async {
    if (await networkInfo!.isConnected) {
      try {
        final parm = await remoteDataSource!.searchBooks(bookName);
        return Right(parm);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BookDetailResponse>> getBookDetails(
      String isbn13) async {
    if (await networkInfo!.isConnected) {
      try {
        final parm = await remoteDataSource!.getBookDetails(isbn13);
        return Right(parm);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getFavoriteBooks() async {
    try {
      final data = await localDataSource!.getFavouriteBooks();
      return Right(data);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> storeFavoriteBooks(List<Book> books) async {
    try {
      final data = await localDataSource!.storeFavoriteBooks(books);
      return Right(data);
    } on Exception {
      return Left(CacheFailure());
    }
  }
}
