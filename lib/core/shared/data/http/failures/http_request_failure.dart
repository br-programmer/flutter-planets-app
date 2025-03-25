sealed class HttpRequestFailure implements Exception {
  const HttpRequestFailure();
  const factory HttpRequestFailure.network() = Network;
  const factory HttpRequestFailure.notFound() = NotFound;
  const factory HttpRequestFailure.internalServer() = InternalServer;
  const factory HttpRequestFailure.serviceUnavailable() = ServiceUnavailable;
  const factory HttpRequestFailure.unauthorized() = Unauthorized;
  const factory HttpRequestFailure.requestNoLongerValid() =
      RequestNoLongerValid;
  const factory HttpRequestFailure.unhandledException({Object? error}) =
      UnhandledException;
}

class Network implements HttpRequestFailure {
  const Network();
}

class NotFound implements HttpRequestFailure {
  const NotFound();
}

class Unauthorized implements HttpRequestFailure {
  const Unauthorized();
}

class InternalServer implements HttpRequestFailure {
  const InternalServer();
}

class ServiceUnavailable implements HttpRequestFailure {
  const ServiceUnavailable();
}

class RequestNoLongerValid implements HttpRequestFailure {
  const RequestNoLongerValid();
}

class UnhandledException implements HttpRequestFailure {
  const UnhandledException({this.error});
  final Object? error;
}
