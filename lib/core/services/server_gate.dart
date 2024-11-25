import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:ziena/core/widgets/flash_helper.dart';
import 'package:ziena/gen/locale_keys.g.dart';

import '../../models/user_model.dart';
import '../routes/app_routes_fun.dart';
import '../routes/routes.dart';
import '../utils/constant.dart';
import '../utils/enums.dart';
import '../utils/loger.dart';

class ServerGate {
  final String _baseUrl = ApiConstants.baseUrl;

  Map<String, dynamic> get constHeader => {
        if (UserModel.i.isAuth) "Authorization": "Bearer ${UserModel.i.token}",
        "Accept": "application/json",
        "Accept-Language": LocaleKeys.lang.tr(),
        "Lang": LocaleKeys.lang.tr(),
      };

  final _dio = Dio();

  ServerGate._() {
    _dio.interceptors.add(CustomApiInterceptor());
  }
  static final ServerGate i = ServerGate._();

  Future<CustomResponse> sendToServer<T>({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? formData,
  }) async {
    try {
      params?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      headers?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      body?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      formData?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      final res = await _dio.post(
        url.startsWith('http') ? url : "$_baseUrl/$url",
        data: formData == null ? (body ?? {}) : FormData.fromMap(formData),
        options: Options(
          headers: {if (headers != null) ...headers, ...constHeader},
          responseType: ResponseType.json,
        ),
        queryParameters: params,
      );
      if ((res.statusCode ?? 404) < 300 && res.data is Map) {
        if (res.data?["IsSuccess"] == false) {
          throw DioException.badResponse(
            statusCode: 422,
            requestOptions: res.requestOptions,
            response: res,
          );
        }
        return CustomResponse<T>(
          success: true,
          data: res.data,
          msg: res.data?["message"] ?? res.data?["SucecssMessage"] ?? "",
          statusCode: 200,
        );
      } else {
        throw DioException.badResponse(
          statusCode: res.statusCode ?? 422,
          requestOptions: res.requestOptions,
          response: res,
        );
      }
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 422,
        errType: ErrorType.unknown,
        msg: kDebugMode ? '$e' : LocaleKeys.something_went_wrong_please_try_again.tr(),
      );
    }
  }

  Future<CustomResponse> deleteFromServer<T>({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? formData,
  }) async {
    try {
      params?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      headers?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      body?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      formData?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      final res = await _dio.delete(
        url.startsWith('http') ? url : "$_baseUrl/$url",
        data: formData == null ? (body ?? {}) : FormData.fromMap(formData),
        options: Options(
          headers: {if (headers != null) ...headers, ...constHeader},
          responseType: ResponseType.json,
        ),
        queryParameters: params,
      );
      if (res.statusCode == 200 && res.data is Map && res.data["IsSuccess"] != false) {
        return CustomResponse<T>(
          success: true,
          data: res.data,
          msg: res.data?["message"] ?? "",
          statusCode: 200,
        );
      } else {
        throw DioException.badResponse(
          statusCode: res.statusCode ?? 422,
          requestOptions: res.requestOptions,
          response: res,
        );
      }
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 422,
        errType: ErrorType.unknown,
        msg: kDebugMode ? '$e' : LocaleKeys.something_went_wrong_please_try_again.tr(),
      );
    }
  }

  Future<CustomResponse> getFromServer<T>({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool constantHeaders = true,
  }) async {
    try {
      params?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      headers?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      final res = await _dio.get(
        url.startsWith('http') ? url : "$_baseUrl/$url",
        options: Options(
          headers: {...constHeader, if (headers != null) ...headers},
          responseType: ResponseType.json,
        ),
        queryParameters: params,
      );
      if (res.statusCode == 200 && res.data is Map) {
        return CustomResponse<T>(
          success: true,
          data: res.data,
          msg: res.data?["message"] ?? "",
          statusCode: 200,
        );
      } else {
        throw DioException.badResponse(
          statusCode: res.statusCode ?? 422,
          requestOptions: res.requestOptions,
          response: res,
        );
      }
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 402,
        errType: ErrorType.unknown,
        msg: LocaleKeys.something_went_wrong_please_try_again.tr(),
      );
    }
  }

  Future<CustomResponse> putToServer<T>({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? formData,
  }) async {
    try {
      params?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      headers?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      body?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      formData?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      final res = await _dio.put(
        url.startsWith('http') ? url : "$_baseUrl/$url",
        data: formData == null ? (body ?? {}) : FormData.fromMap(formData),
        options: Options(
          headers: {if (headers != null) ...headers, ...constHeader},
          responseType: ResponseType.json,
        ),
        queryParameters: params,
      );
      if (res.statusCode == 200 && res.data is Map) {
        return CustomResponse<T>(
          success: true,
          data: res.data,
          msg: res.data?["message"] ?? "",
          statusCode: 200,
        );
      } else {
        throw DioException.badResponse(
          statusCode: res.statusCode ?? 422,
          requestOptions: res.requestOptions,
          response: res,
        );
      }
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 422,
        errType: ErrorType.unknown,
        msg: kDebugMode ? '$e' : LocaleKeys.something_went_wrong_please_try_again.tr(),
      );
    }
  }

  Future<CustomResponse> patchToServer<T>({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? formData,
  }) async {
    try {
      params?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      headers?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      body?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      formData?.removeWhere((key, value) => value == null || '$value'.isEmpty);
      final res = await _dio.patch(
        url.startsWith('http') ? url : "$_baseUrl/$url",
        data: formData == null ? (body ?? {}) : FormData.fromMap(formData),
        options: Options(
          headers: {if (headers != null) ...headers, ...constHeader},
          responseType: ResponseType.json,
        ),
        queryParameters: params,
      );
      if (res.statusCode == 200 && res.data is Map) {
        return CustomResponse<T>(
          success: true,
          data: res.data,
          msg: res.data?["message"] ?? "",
          statusCode: 200,
        );
      } else {
        throw DioException.badResponse(
          statusCode: res.statusCode ?? 422,
          requestOptions: res.requestOptions,
          response: res,
        );
      }
    } on DioException catch (e) {
      return handleServerError(e);
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: 422,
        errType: ErrorType.unknown,
        msg: kDebugMode ? '$e' : LocaleKeys.something_went_wrong_please_try_again.tr(),
      );
    }
  }

  CustomResponse<T> handleServerError<T>(DioException err) {
    if (err.type == DioExceptionType.badResponse) {
      if (err.response?.data.toString().isEmpty ?? false) {
        err.response?.data = {};
      } else if (err.response?.data is! Map) {
        err.response?.data = {"message": "${err.response?.data}"};
      }
      if (err.response?.statusCode == 401) {
        UserModel.i.clear();
        pushAndRemoveUntil(NamedRoutes.login);
        FlashHelper.showToast(LocaleKeys.session_expired.tr());
        return CustomResponse(
          success: false,
          statusCode: err.response?.statusCode ?? 401,
          errType: ErrorType.unAuth,
          msg: err.response?.data["message"] ?? err.response?.data["Message"] ?? err.response?.data["ErrorMessage"] ?? "",
          data: err.response?.data,
        );
      } else if ((err.response!.data.toString().contains("DOCTYPE") ||
          err.response!.data.toString().contains("<script>") ||
          err.response!.data["exception"] != null)) {
        return CustomResponse(
          success: false,
          errType: ErrorType.server,
          statusCode: err.response!.statusCode ?? 500,
          msg: kDebugMode ? "${err.response!.data}" : LocaleKeys.something_went_wrong_please_try_again.tr(),
        );
      } else {
        return CustomResponse(
          success: false,
          statusCode: err.response?.statusCode ?? 500,
          errType: ErrorType.backEndValidation,
          msg: err.response?.data["message"] ?? err.response?.data["Message"] ?? err.response?.data["ErrorMessage"] ?? "",
          data: err.response?.data,
        );
      }
    } else if (err.type == DioExceptionType.receiveTimeout || err.type == DioExceptionType.sendTimeout) {
      return CustomResponse(
        success: false,
        statusCode: err.response?.statusCode ?? 500,
        errType: ErrorType.network,
        msg: LocaleKeys.poor_connection_check_the_quality_of_the_internet.tr(),
        data: err.response?.data,
      );
    } else if (err.response == null) {
      return CustomResponse(
        success: false,
        statusCode: 402,
        errType: ErrorType.network,
        msg: LocaleKeys.please_check_your_internet_connection.tr(),
        data: err.response?.data,
      );
    } else {
      return CustomResponse(
        success: false,
        statusCode: 402,
        errType: ErrorType.unknown,
        msg: LocaleKeys.something_went_wrong_please_try_again.tr(),
        data: err.response?.data,
      );
    }
  }
}

class CustomApiInterceptor extends Interceptor {
  final log = LoggerDebug(headColor: LogColors.red, constTitle: "Server Gate Logger");
  CustomApiInterceptor();
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.red("\x1B[37m------ Current Error Response (status code ${err.response?.statusCode}) -----\x1B[0m");
    log.red("\x1B[31m${jsonEncode(err.response?.data)}\x1B[0m");
    return super.onError(err, handler);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    log.green("------ Current Response (status code ${response.statusCode}) ------");
    log.green(jsonEncode(response.data), response.requestOptions.path.replaceFirst(ApiConstants.baseUrl, ''));
    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.yellow("------ Current Request Path -----");
    log.yellow("${options.path} ${LogColors.red}API METHOD : (${options.method})${LogColors.reset}");
    if (options.data != null) {
      log.cyan("------ Current Request body Data -----");
      if (options.data is FormData) {
        FormData dd = options.data;
        Map<String, dynamic> body = {};
        for (var element in dd.fields) {
          body[element.key] = element.value;
        }

        for (var element in dd.files) {
          body[element.key] = element.value.filename;
        }

        log.cyan(jsonEncode(body));
      } else {
        log.cyan(jsonEncode(options.data));
      }
    }
    log.white("------ Current Request Parameters Data -----");
    log.white(jsonEncode(options.queryParameters));
    log.yellow("------ Current Request Headers -----");
    log.yellow(jsonEncode(options.headers));
    return super.onRequest(options, handler);
  }
}

class CustomResponse<T> {
  bool success;
  ErrorType errType;
  String msg;
  int statusCode;
  T? data;

  CustomResponse({
    this.success = false,
    this.errType = ErrorType.none,
    this.msg = "",
    this.statusCode = 0,
    this.data,
  });
}
