import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none &&
            requestOptions.method == 'GET') {
          streamSubscription?.cancel();
          // Complete the completer instead of returning
          final options = Options(
            method: requestOptions.method,
            receiveDataWhenStatusError: false,
            headers: <String, dynamic>{
              ...requestOptions.headers,
            },
            extra: <String, dynamic>{
              'secure': <Map<String, String>>[
                {
                  'type': 'http',
                  'name': 'Authorization',
                },
              ],
              ...requestOptions.extra,
            },
            contentType: [
              'application/json',
            ].first,
            validateStatus: requestOptions.validateStatus,
          );
          responseCompleter.complete(
            dio.request(
              '${requestOptions.baseUrl}${requestOptions.path}',
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: options,
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
