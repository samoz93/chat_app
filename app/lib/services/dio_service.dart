import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

getDioClient() {
  var dio = Dio(
    BaseOptions(
      followRedirects: true,
      validateStatus: (status) {
        return true;
      },
    ),
  ); // some dio configurations
  dio.interceptors.add(CookieManager(CookieJar()));
  return dio;
}
