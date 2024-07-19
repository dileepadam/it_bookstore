import 'package:equatable/equatable.dart';

import '../features/data/models/responses/error_response_model.dart';




abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => props;
}

class ServerFailure extends Failure {
  final ErrorResponseModel errorResponse;

  ServerFailure(this.errorResponse);
}

class APIFailure extends Failure {
  final ErrorResponseModel errorResponse;

  APIFailure(this.errorResponse);
}

class CacheFailure extends Failure {}

class ConnectionFailure extends Failure {}

