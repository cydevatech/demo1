import 'package:envify/envify.dart';

@Envify()
abstract class Env {
  static const String url = 'http://demo1.com:8004/';
  // static const String url = 'http://103.11.199.134:8004/';
  // static const String url = 'http://0.tcp.ap.ngrok.io:16656/';
}
