import 'package:fpdart/fpdart.dart';
import 'package:it_bookstore/error/failures.dart';
import 'package:it_bookstore/features/data/models/common/base_response.dart';
import 'package:it_bookstore/features/data/models/responses/book_detail_response.dart';

abstract class Repository {
  Future<Either<Failure, BaseResponse>> getNewBooks();

  Future<Either<Failure, BaseResponse>> searchBooks(String bookName);

  Future<Either<Failure, BookDetailResponse>> getBookDetails(String isbn13);

  Future<Either<Failure, List<Book>>> getFavoriteBooks();

  Future<Either<Failure, bool>> storeFavoriteBooks(List<Book> books);
}
