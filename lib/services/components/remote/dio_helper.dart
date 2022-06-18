import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery_task/services/components/remote/url.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Url.movieDbBaseUrl,
        connectTimeout: 50000,
        receiveTimeout: 30000,
        followRedirects: false,
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }

  static Future<Response> getData({
    @required String? url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? apiKey,
  }) async {
    dio!.options.headers = {
      'Authorization': apiKey ,
    };

    return await dio!.get(
      url!,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    @required String? url,
    @required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Accept-Language': lang,
      'Authorization': token,
    };

    return dio!.post(
      url!,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    @required String? url,
    @required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token??'',
    };
    return dio!.put(
      url!,
      queryParameters: query,
      data: data,
    );
  }
}