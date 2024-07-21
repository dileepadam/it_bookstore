import 'package:dio/dio.dart';

import 'failures.dart';

class ErrorHandler {



  ///error_messages
  static const String errorSomethingWentWrong = "Something went wrong!";

  ///error_title
  static const String title = "Error";



  String? mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ConnectionFailure:
        return 'Unable to connect. Please check your internet connection.';
      case ServerFailure:
        return (failure as ServerFailure).errorResponse.errorDescription;
      default:
        return 'Something went wrong.';
    }
  }

String handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return "Connection timed out. Please try again.";
    case DioExceptionType.sendTimeout:
      return "Request timed out while sending. Please try again.";
    case DioExceptionType.receiveTimeout:
      return "Response timed out. Please try again.";
    case DioExceptionType.badResponse:
      return "The server encountered an error. Please try again later."; 
    case DioExceptionType.cancel:
      return "Request canceled.";
    case DioExceptionType.unknown:
      return "Unable to connect. Please check your internet connection.";
    case DioExceptionType.connectionError:
      return "Connection error. Please try again.";
    default:
      return "Something went wrong.";
  }
}
}
