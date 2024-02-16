import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

class ExceptionMessageMapper {
  const ExceptionMessageMapper();

  String map(AppException appException) {
    return switch (appException.appExceptionType) {
      AppExceptionType.remote => switch ((appException as RemoteException).kind) {
          RemoteExceptionKind.badCertificate =>
            localisation.unknownException('UE-01'),
          RemoteExceptionKind.noInternet => localisation.noInternetException,
          RemoteExceptionKind.network => localisation.canNotConnectToHost,
          RemoteExceptionKind.serverDefined =>
            appException.generalServerMessage ??
                localisation.unknownException('UE-02'),
          RemoteExceptionKind.serverUndefined =>
            appException.generalServerMessage ??
                localisation.unknownException('UE-03'),
          RemoteExceptionKind.timeout => localisation.timeoutException,
          RemoteExceptionKind.cancellation =>
            localisation.unknownException('UE-04'),
          RemoteExceptionKind.unknown => localisation.unknownException('UE-05'),
          RemoteExceptionKind.refreshTokenFailed => localisation.tokenExpired,
          RemoteExceptionKind.decodeError =>
            localisation.unknownException('UE-06'),
        },
      AppExceptionType.parse => localisation.unknownException('UE-10'),
      AppExceptionType.uncaught => localisation.unknownException('UE-00'),
      AppExceptionType.validation => switch ((appException as ValidationException).kind) {
          ValidationExceptionKind.emptyEmail => localisation.emptyEmail,
          ValidationExceptionKind.invalidEmail => localisation.invalidEmail,
          ValidationExceptionKind.invalidPassword =>
            localisation.invalidPassword,
          ValidationExceptionKind.invalidUserName =>
            localisation.invalidUserName,
          ValidationExceptionKind.invalidPhoneNumber =>
            localisation.invalidPhoneNumber,
          ValidationExceptionKind.invalidDateTime =>
            localisation.invalidDateTime,
          ValidationExceptionKind.passwordsAreNotMatch =>
            localisation.passwordsAreNotMatch,
        },
      AppExceptionType.remoteConfig => localisation.unknownException('UE-100'),
    };
  }
}
