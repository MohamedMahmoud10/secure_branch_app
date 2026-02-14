import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:secure_branch_app/core/error_handling/index.dart';
import 'package:secure_branch_app/core/infrastructure/network/status_code.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

class DioHandlerExc implements Exception {
  final Failure failure;

  DioHandlerExc.handle(dynamic error) : failure = _handleError(error);

  static Failure _handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is DioHandlerExc) {
      return error.failure;
    } else {
      return ServerFailure('Something went wrong');
    }
  }

  static Failure _handleDioError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Connection timeout');
      case DioExceptionType.badResponse:
        final int? statusCode = exception.response?.statusCode;
        final String message = _getErrorMessageForStatusCode(statusCode);
        AppLogger().error('Error message:Error message: $message');
        return ServerFailure(message);
      case DioExceptionType.cancel:
        return ServerFailure('Request was cancelled');
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      return ServerFailure('Unknown Error');
    }
  }

  static String _getErrorMessageForStatusCode(int? statusCode) {
    AppLogger().info('The Status Code Is $statusCode');
    switch (statusCode) {
      case StatusCode.badRequest:
        return LocaleKeys.invalidSyntax.tr();
      case StatusCode.unauthorized:
        return LocaleKeys.invalidSyntax.tr();
      case StatusCode.forbidden:
        return LocaleKeys.invalidSyntax.tr();
      case StatusCode.notFound:
        return LocaleKeys.invalidSyntax.tr();
      case StatusCode.internalServerError:
        return LocaleKeys.invalidSyntax.tr();
      default:
        return LocaleKeys.invalidSyntax.tr();
    }
  }
}
