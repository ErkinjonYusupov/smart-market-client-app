import 'package:client_mobile_app/exports.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyInterceptor extends Interceptor {
  MyInterceptor();
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await GetStorage().remove('token');
      Get.offAll(() => const LoginPage());
      return;
    }
    if (err.response?.statusCode == 500) {
      Get.dialog(ErrorDialog(text: err.response!.statusMessage.toString()));
    } else {
      if (err.response?.statusCode == 400) {
        Get.dialog(ErrorDialog(text: err.response!.data['message'].toString()));
      } else {
        if (err.response != null) {
          Get.dialog(ErrorDialog(text: err.response!.statusMessage.toString()));
        }
      }
    }
    super.onError(err, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await GetStorage().read('token');
    options.headers['Authorization'] = token;
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    options.baseUrl = dotenv.env['BASE_URL'].toString();
    super.onRequest(options, handler);
  }
}

class MyDio {
  final Dio _dio = Dio();
  MyDio() {
    _dio.interceptors.add(MyInterceptor());
  }
  Dio dio() {
    return _dio;
  }
}
