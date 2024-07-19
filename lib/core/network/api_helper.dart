import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';

import '../../error/exceptions.dart' as exe;
import '../../error/messages.dart';
import '../../features/data/models/responses/error_response_model.dart';
import 'network_config.dart';

class APIHelper {
  final Dio? dio;

  APIHelper({this.dio}) {
    _initApiClient();
  }

  Future<void> _initApiClient() async {
    final logInterceptor = LogInterceptor();

    final BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: kConnectionTimeout),
        receiveTimeout: const Duration(seconds: kReceiveTimeout),
        persistentConnection: true,
        baseUrl: NetworkConfig.getNetworkUrl(),
        contentType: 'application/json');

    dio
      ?..options = options
      ..interceptors.add(logInterceptor)
      ..httpClientAdapter = Http2Adapter(
          ConnectionManager(
            idleTimeout: Duration(seconds: 15),
          ), fallbackAdapter: IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          return client;
        },
      ));
  }

  Future<dynamic> get(String url) async {
    try {
      final response = await dio!.get(NetworkConfig.getNetworkUrl() + url);
      log("[API Helper - GET] response ${response}");
      return response.data;
    } on DioException catch (e) {
      log('[API Helper - GET] Connection Exception => ${e.message}');
      if (e.response != null) {
        final int statusCode = e.response!.statusCode!;

        if (statusCode < 200 || statusCode > 400) {
          switch (statusCode) {
            case 404:
              throw exe.ServerException(ErrorResponseModel(
                  errorDescription: ErrorHandler.errorSomethingWentWrong));
            case 500:
            default:
              throw exe.DioException(
                  errorResponseModel: ErrorResponseModel(
                      errorCode: e.response?.statusCode.toString(),
                      errorDescription: e.response?.statusMessage));
          }
        }
      } else {
        throw exe.ServerException(ErrorResponseModel(
            errorDescription: ErrorHandler().handleDioError(e)));
      }
    }
  }
}
