import 'package:fpdart/fpdart.dart';
import 'package:it_bookstore/error/failures.dart';
import 'package:it_bookstore/features/data/models/common/base_response.dart';

abstract class Repository {
  Future<Either<Failure, BaseResponse>> getNewBooks();
}
