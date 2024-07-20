import 'package:fpdart/src/either.dart';
import 'package:it_bookstore/error/failures.dart';
import 'package:it_bookstore/features/data/models/responses/book_detail_response.dart';
import 'package:it_bookstore/features/domain/repository/repository.dart';
import 'package:it_bookstore/features/domain/usecases/usecase.dart';

class GetBookDetails extends UseCase<BookDetailResponse, String> {
  final Repository? repository;

  GetBookDetails({this.repository});

  @override
  Future<Either<Failure, BookDetailResponse>> call(String isbn13) async {
    return repository!.getBookDetails(isbn13);
  }
}
