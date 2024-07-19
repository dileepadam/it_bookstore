import '../models/common/base_response.dart';

abstract class RemoteDataSource {
  Future<BaseResponse> getNewBooks();
}
