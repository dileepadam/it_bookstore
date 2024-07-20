import 'package:fpdart/src/either.dart';
import 'package:it_bookstore/error/exceptions.dart';
import 'package:it_bookstore/error/failures.dart';
import 'package:it_bookstore/features/data/datasources/remote_data_source.dart';
import 'package:it_bookstore/features/data/models/common/base_response.dart';
import 'package:it_bookstore/features/domain/repository/repository.dart';

import '../../../core/network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource? remoteDataSource;
  final NetworkInfo? networkInfo;

  RepositoryImpl({required this.remoteDataSource, required this.networkInfo});

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
}
