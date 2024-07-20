import 'package:it_bookstore/features/data/datasources/remote_data_source.dart';
import 'package:it_bookstore/features/data/models/common/base_response.dart';
import 'package:it_bookstore/features/data/models/responses/book_detail_response.dart';

import '../../../core/network/api_helper.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final APIHelper? apiHelper;

  RemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<BaseResponse> getNewBooks() async {
    try {
      final response = await apiHelper?.get("new");
      return BaseResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse> searchBooks(String bookName) async {
    try {
      final response = await apiHelper?.get("search/$bookName");
      return BaseResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BookDetailResponse> getBookDetails(String isbn13) async {
    try {
      final response = await apiHelper?.get("books/$isbn13");
      return BookDetailResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }
}
