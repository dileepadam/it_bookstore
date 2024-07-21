import 'package:fpdart/src/either.dart';
import 'package:it_bookstore/error/failures.dart';
import 'package:it_bookstore/features/data/models/common/base_response.dart';
import 'package:it_bookstore/features/domain/repository/repository.dart';
import 'package:it_bookstore/features/domain/usecases/usecase.dart';

class StoreFavoriteBooks extends UseCase<bool, List<Book>> {
  final Repository? repository;

  StoreFavoriteBooks({this.repository});

  @override
  Future<Either<Failure, bool>> call(List<Book> params) async {
    return repository!.storeFavoriteBooks(params);
  }
}
