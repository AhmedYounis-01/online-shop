import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        // connectTimeout: const Duration(seconds: 7),
        // sendTimeout: const Duration(seconds: 7),
        // receiveTimeout: const Duration(seconds: 7),
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token =
        "uINsiAb2kNgFAsu6yz4pPPoSaI3IONMYV7jld89d0bHBeh1w7e3nRe9fYL6W0u0bnZBX8y",
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response?> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token =
        "uINsiAb2kNgFAsu6yz4pPPoSaI3IONMYV7jld89d0bHBeh1w7e3nRe9fYL6W0u0bnZBX8y",
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token,
    };

    return dio.post(
      url,
      // queryParameters: query,
      data: data,
    );
  }

  static Future<Response?> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token =
        "uINsiAb2kNgFAsu6yz4pPPoSaI3IONMYV7jld89d0bHBeh1w7e3nRe9fYL6W0u0bnZBX8y",
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token,
    };

    //! data : { : } => that taken from user
    return dio.put(
      url,
      // queryParameters: query,
      data: data,
    );
  }
}
