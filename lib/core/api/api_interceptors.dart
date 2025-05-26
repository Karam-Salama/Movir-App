import 'package:dio/dio.dart';

import '../utils/api_const.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ! Needed Headers For My Requests
    options.headers[ApiKeys.authorization] = APIConst.accessToken;
    options.headers[ApiKeys.accept] = 'application/json';

    super.onRequest(options, handler);
  }
}
