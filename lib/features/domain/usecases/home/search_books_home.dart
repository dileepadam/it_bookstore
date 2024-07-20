import 'package:fpdart/src/either.dart';
import 'package:it_bookstore/error/failures.dart';
import 'package:it_bookstore/features/data/models/common/base_response.dart';
import 'package:it_bookstore/features/domain/usecases/usecase.dart';

import '../../repository/repository.dart';

class SearchHomePageData extends UseCase<BaseResponse, String> {
  final Repository? repository;

  SearchHomePageData({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(String bookName) {
    return repository!.searchBooks(bookName);
  }
}
