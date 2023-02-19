import '../errors/error_message_model.dart';

class NetworkException implements Exception {
  final ErrorMessageModel errorMessageModel;

  const NetworkException({required this.errorMessageModel});
}

