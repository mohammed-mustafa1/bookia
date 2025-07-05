import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  const Failure({required this.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(message: 'Connection Timeout');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(message: 'Receive Timeout');
      case DioExceptionType.badCertificate:
        return const ServerFailure(message: 'Bad Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            statusCode: dioException.response!.statusCode!,
            response: dioException.response!);

      case DioExceptionType.cancel:
        return const ServerFailure(message: 'Request Canceled');
      case DioExceptionType.connectionError:
        return const ServerFailure(message: 'Connection Error');
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return const ServerFailure(message: 'No Internet Connection');
        } else {
          return const ServerFailure(message: 'Unexpected Error');
        }
      default:
        return const ServerFailure(message: 'Opps There was an Error');
    }
  }
  factory ServerFailure.fromResponse(
      {required int statusCode, required Response response}) {
    if (statusCode == 400 || statusCode == 403) {
      return ServerFailure(message: response.data['error']['message']);
    } else if (statusCode == 401) {
      return ServerFailure(message: response.data['message']);
    } else if (statusCode == 404) {
      return ServerFailure(message: 'Your Request not found, Pleas try later!');
    } else if (statusCode == 500) {
      return ServerFailure(message: 'Internal Server Error, Pleas try later');
    } else {
      var errorHeader = response.data['message'] ?? 'Opps There was an Error';
      var message = response.data['errors'] ?? '';
      if (message is Map<String, dynamic>) {
        message =
            message.values.expand((message) => message).join(', ').toString();
      }

      return ServerFailure(message: '$errorHeader $message');
    }
  }
}
