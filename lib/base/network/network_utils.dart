import 'package:dio/dio.dart';

class NetWorkUtils {
  static Future<Response> get(url) async {
    var response = await Dio().get(url);
    // print("response.data")
    return response.data;
  }
}
