

import '../features/data/models/responses/error_response_model.dart';

class ServerException implements Exception {
  final ErrorResponseModel errorResponseModel;

  ServerException(this.errorResponseModel);
}

class APIFailException implements Exception {
  final ErrorResponseModel errorResponseModel;

  APIFailException(this.errorResponseModel);
}

class CacheException implements Exception {}


class DioException implements Exception {
  final ErrorResponseModel errorResponseModel;

  DioException({required this.errorResponseModel});
}
