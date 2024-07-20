import '../models/common/base_response.dart';
import '../models/responses/book_detail_response.dart';

abstract class RemoteDataSource {
  Future<BaseResponse> getNewBooks();

  Future<BaseResponse> searchBooks(String bookName);

  Future<BookDetailResponse> getBookDetails(String isbn13);
}
