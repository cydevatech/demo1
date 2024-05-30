import 'package:dio/dio.dart';
import 'package:demo1/api/base_api.dart';
import 'package:demo1/api/rest_client_factory.dart';
import 'package:demo1/models/default_data.dart';

import 'package:demo1/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(RestClientFactory restClient)
      : _baseApi = restClient.obtainRestClient(),
        dio = restClient.obtainDio();
  final BaseApi _baseApi;
  final Dio dio;

  // @override
  // Future<DefaultModel> checkExists({String? phone}) {
  //   final body = {
  //     'phone_number': phone,
  //   };
  //   return _baseApi.checkExist(body);
  // }
}
