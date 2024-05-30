import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:demo1/api/retry_interceptor.dart';

import '../env.dart';
import 'base_api.dart';
import 'dio_connectivity_request_retrier.dart';

const Duration _kTimeout = Duration(milliseconds: 60000);

@singleton
class RestClientFactory {
  BehaviorSubject<Exception> dioErrorSubject = BehaviorSubject();

  Stream<Exception> get dioErrorStream => dioErrorSubject.stream;

  Dio obtainDio() {
    final dio = Dio();
    dio.options.connectTimeout = _kTimeout;
    dio.options.receiveTimeout = _kTimeout;
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
          responseBody: true,
          logPrint: (data) {
            log("Api Response: $data");
          }));
    }
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
        dioErrorSubject: (dioError) {
          dioErrorSubject.add(dioError);
        },
      ),
    );
    return dio;
  }

  BaseApi obtainRestClient() {
    return BaseApi(obtainDio(), baseUrl: Env.url);
  }
}
