import 'dart:async';
import 'dart:io';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';

class ApiRequest {
  String requestUrl;
  dynamic body;
  dynamic queryParameter;

  ApiRequest({
    this.requestUrl,
    this.body,
    this.queryParameter,
  });

  static Dio dio = Dio(BaseOptions(
      baseUrl: Config.BASE_URl,
      // connectTimeout: 30000,
      // receiveTimeout: 30000,
      responseType: ResponseType.json));

  static DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
  static Options _cacheOptions = buildCacheOptions(Duration(days: 7),
      forceRefresh: true, maxStale: Duration(days: 10));

  Future<Response> postRequest() async {
    Response response;
    dio.options.headers["authorization"] = "Bearer ${Config.requestToken}";
    print(Config.requestToken);
    print('gg');
    try {
      response = await dio.post(requestUrl, data: body, options: _cacheOptions);
      dio.interceptors.add(_dioCacheManager.interceptor);
    } on DioError catch (e) {
      response = null;
      error(dioError: e, functionParameter: requestUrl);
    }
    return response;
  }

  static error({DioError dioError, String functionParameter, String error}) {
    Utils.displayErrorPrint(
        message: functionParameter + ' ' + dioError.response.toString());
    // Utils.showMessage(message: dioError.error.toString(), color: Colors.red);
  }

  static Future<File> downloadPdf(String url) async {
    try {
      print(url);
      Response response = await dio.get(url,
          // onReceiveProgress: showDownloadProgress,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: true,
              validateStatus: (status) {
                return status < 500;
              }));
      print(response.headers);
      File file = File('${(await getTemporaryDirectory()).path}/xyz.pdf');

      return await file.writeAsBytes(await response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Response> sendRequest(
      {String requestUrlData,
      dynamic bodyData,
      dynamic queryParameterDat,
      bool isPostRequest,
      RxInt statusCode,
      RxBool isFetching}) async {
    statusCode.value = 0;
    isFetching(true);
    Response<dynamic> responseData;
    ApiRequest apiService = ApiRequest();
    apiService.body = bodyData;
    apiService.requestUrl = requestUrlData;
    if (await checkIsConnectEstablish()) {
      Utils.showMessage(
          message: "Please check your internet connection or try again later");
      statusCode.value = 300;
    } else {
      await apiService.postRequest().then((Response<dynamic> response) async {
        if (response != null) {
          Map<String, dynamic> output =
              Map<String, dynamic>.from(await response.data);
          if (response.statusCode == 200) {
            if (await response.data != null) {
              responseData = response;
            } else {
              statusCode.value = 401;
            }
          } else {
            print("error");
            //statusCode.value = output['status_code'];
          }
        } else {
          statusCode.value = 502;
        }
      }).catchError((error) => {print(error)});
    }
    return responseData;
  }

  static Future<bool> checkIsConnectEstablish() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none;
  }
}


// import 'dart:async';
// import 'package:xborders/core/api/config/config.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_http_cache/dio_http_cache.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';

// class ApiRequest {
//   String requestUrl;
//   dynamic body;
//   dynamic queryParameter;

//   ApiRequest({
//     this.requestUrl,
//     this.body,
//     this.queryParameter,
//   });

//   static Dio dio = Dio(
//     BaseOptions(
//         baseUrl: Config.BASE_URl,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         // connectTimeout: 30000,
//         // receiveTimeout: 30000,
//         responseType: ResponseType.json),
//   );

//   static DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
//   static Options _cacheOptions = buildCacheOptions(Duration(days: 7),
//       forceRefresh: true, maxStale: Duration(days: 10));

//   static get token => Config.loginUrl;

//   Future<Response> postRequest() async {
//     // dio.options.headers = {

//     //   "responseHeader": ["Access-Control-Allow-Origin"],
//     //   HttpHeaders.userAgentHeader: 'dio',
//     //   'header': "Access-Control-Allow-Origin: *",
//     //   "Access-Control-Allow-Credentials": true,
//     //   "Access-Control-Allow-Methods": "GET, OPTIONS",

//     // };
//     dio.options.headers["authorization"] = "token ${Config.requestToken}";
//     print(body);
//     print(requestUrl);
//     print(_cacheOptions);
//     Response response;
//     try {
//       response = await dio.post(requestUrl, data: body, options: _cacheOptions);
//       dio.interceptors.add(_dioCacheManager.interceptor);
//     } on DioError catch (e) {
//       response = null;
//       error(dioError: e, functionParameter: requestUrl);
//     }
//     return response;
//   }

//   static void showDownloadProgress(received, total) {
//     if (total != -1) {
//       print((received / total * 100).toStringAsFixed(0) + "%");
//     }
//   }

//   static error({DioError dioError, String functionParameter, String error}) {
//     // Utils.showMessage(message: dioError.error.toString(), color: Colors.red);
//   }

//   static Future<Response> sendRequest(
//       {String requestUrlData,
//       dynamic bodyData,
//       dynamic queryParameterDat,
//       bool isPostRequest,
//       RxInt statusCode,
//       RxBool isFetching}) async {
//     statusCode.value = 0;
//     isFetching(true);
//     Response<dynamic> responseData;
//     ApiRequest apiService = ApiRequest();
//     apiService.body = bodyData;
//     apiService.requestUrl = requestUrlData;

//     if (await checkIsConnectEstablish()) {
//       statusCode.value = 300;
//     } else {
//       await apiService.postRequest().then((Response<dynamic> response) async {
//         if (response != null) {
//           Map<String, dynamic> output =
//               Map<String, dynamic>.from(await response.data);
//           if (response.statusCode == 200 &&
//               await output['status_code'] == 200) {
//             if (await response.data != null) {
//               responseData = response;
//             } else {
//               statusCode.value = 401;
//             }
//           } else {
//             statusCode.value = output['status_code'];
//           }
//         } else {
//           statusCode.value = 502;
//         }
//       }).catchError((error) => '');
//     }
//     return responseData;
//   }

//   static Future<bool> checkIsConnectEstablish() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     return connectivityResult == ConnectivityResult.none;
//   }

//   static Future<bool> notEmpty(
//       Response<dynamic> response, String dataString, RxInt statusCode,
//       {bool notEmpty = true}) async {
//     if (notEmpty) {
//       if (response != null && await response.data[dataString].length > 0) {
//         return true;
//       } else {
//         return false;
//       }
//     } else {
//       if (response != null && await response.data != null) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//   }

//   static checkIsState(RxInt statusCode) async {
//     if (await checkIsConnectEstablish()) {
//       statusCode.value = 300;
//     }
//   }
// }
