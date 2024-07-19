import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:it_bookstore/error/failures.dart';
import 'package:it_bookstore/features/data/models/common/base_response.dart';

import '../../repository/repository.dart';
import '../usecase.dart';

class GetHomePageData extends UseCase<BaseResponse, Params> {
  final Repository? repository;

  GetHomePageData({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(Params params) async {
    return repository!.getNewBooks();
  }
}

class Params extends Equatable {
  const Params();

  @override
  List<Object> get props => [];
}
