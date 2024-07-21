import 'package:fpdart/src/either.dart';
import 'package:it_bookstore/error/failures.dart';
import 'package:it_bookstore/features/data/models/common/base_response.dart';
import 'package:it_bookstore/features/domain/repository/repository.dart';
import 'package:it_bookstore/features/domain/usecases/home/get_home_page_data.dart';
import 'package:it_bookstore/features/domain/usecases/usecase.dart';

class GetFavouriteBooks extends UseCase<List<Book>, Params> {
  final Repository? repository;

  GetFavouriteBooks({this.repository});

  @override
  Future<Either<Failure, List<Book>>> call(Params params) async {
    return repository!.getFavoriteBooks();
  }
}
