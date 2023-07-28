import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:taskhub/features/domain/entities/UserDetailsModel.dart';
import 'package:taskhub/utility/constants_api_endpoints.dart';

class DioApiClient {
  late Dio dio;

  DioApiClient () {
    dio = Dio(BaseOptions(
      baseUrl: ConstantsApiEndPoints.baseUrl
    ));
    initializeInterceptor();
  }

  initializeInterceptor () {
    dio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response?> getRequest(String endPoint,String uid) async {
    Response? response;
    try{
      response = await dio.get(endPoint,data: {"_id":uid});
    }on DioException catch(error) {
      if(kDebugMode) print("Dio Get Request error : ${error.message}");
    }
    return response;
  }

  Future<Response?> postRequest(String endPoint,Map<String,dynamic> userDetailsModel) async {
    Response response;
    try{
      response = await dio.post(endPoint,data: userDetailsModel);
      return response;
    }on DioException catch(error) {
      if(kDebugMode) print("Dio Get Request error : ${error.message}");
    }
  }

  Future<Response?> putRequest(String endPoint,Map<String,dynamic> data) async {
    Response response;
    try{
      response = await dio.put(endPoint,data: data);
      return response;
    }on DioException catch(error) {
      if(kDebugMode) print("Dio Get Request error : ${error.message}");
    }
  }

}