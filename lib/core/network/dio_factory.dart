import 'package:dio/dio.dart';

class DioFactory {
  Dio getDioObject() {
    Dio dio = Dio();
    dio
      ..options.connectTimeout = const Duration(milliseconds: 1 * 6000)
      ..options.receiveTimeout = const Duration(milliseconds: 1 * 5000);
    dio.interceptors.add(LogInterceptor(
      responseHeader: true,
      responseBody: true,
      requestHeader: true,
      requestBody: true,
      request: true,
      error: true,
    ));
    return dio;
  }
}