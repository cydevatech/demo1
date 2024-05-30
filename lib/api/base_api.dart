import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'base_api.g.dart';

@RestApi()
abstract class BaseApi {
  factory BaseApi(Dio dio, {String baseUrl}) = _BaseApi;

  // Auth
  // @POST('/api/v1/auth/user/check/exist/')
  // Future<DefaultModel> checkExist(@Body() Map<String, dynamic> body);
}
