import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:single_store_app/src/app/constants/dart_define.constants.dart';
import 'package:single_store_app/src/app/constants/strings/app_repo.constants.dart';
import 'package:single_store_app/src/app/models/authentication/server_token.dart';
import 'package:single_store_app/src/app/models/infrastructure/api_error.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

import 'app_cache.dart';
import 'app_exception.dart';
import 'app_http.dart';

abstract class AppRepo {
  AppRepo({
    required this.appRepoCubit,
    required this.multiStoreUrl,
  });

  AppRepoCubit appRepoCubit;
  bool multiStoreUrl;

  String _multiStoreUrl({
    required String controllerSegment,
    required String? apiSegment,
    required bool multiStoreUrlOverride,
  }) {
    if (multiStoreUrlOverride) {
      if (apiSegment == null) {
        return 'https://${PackageConstants.url}${PackageConstants.apiSegment}$controllerSegment';
      } else {
        return 'https://${PackageConstants.url}${PackageConstants.apiSegment}$controllerSegment/$apiSegment';
      }
    } else {
      if (apiSegment == null) {
        if (multiStoreUrl) {
          if (appRepoCubit.state.businessSelectBloc.state.isMultiStore) {
            return 'https://${PackageConstants.url}${PackageConstants.apiSegment}$controllerSegment/${appRepoCubit.state.businessSelectBloc.state.selectedBusinessIdentity}';
          } else {
            return 'https://${PackageConstants.url}${PackageConstants.apiSegment}$controllerSegment';
          }
        } else {
          return 'https://${PackageConstants.url}${PackageConstants.apiSegment}$controllerSegment';
        }
      } else {
        if (multiStoreUrl) {
          if (appRepoCubit.state.businessSelectBloc.state.isMultiStore) {
            return 'https://${PackageConstants.url}${PackageConstants.apiSegment}$controllerSegment/${appRepoCubit.state.businessSelectBloc.state.selectedBusinessIdentity}/$apiSegment';
          } else {
            return 'https://${PackageConstants.url}${PackageConstants.apiSegment}$controllerSegment/$apiSegment';
          }
        } else {
          return 'https://${PackageConstants.url}${PackageConstants.apiSegment}$controllerSegment/$apiSegment';
        }
      }
    }
  }

  String _multiStorePath({
    required String controllerSegment,
    required String? apiSegment,
    required bool multiStoreUrlOverride,
  }) {
    if (multiStoreUrlOverride) {
      if (apiSegment == null) {
        return '${PackageConstants.apiSegment}$controllerSegment';
      } else {
        return '${PackageConstants.apiSegment}$controllerSegment/$apiSegment';
      }
    } else {
      if (apiSegment == null) {
        if (multiStoreUrl) {
          if (appRepoCubit.state.businessSelectBloc.state.isMultiStore) {
            return '${PackageConstants.apiSegment}$controllerSegment/${appRepoCubit.state.businessSelectBloc.state.selectedBusinessIdentity}';
          } else {
            return '${PackageConstants.apiSegment}$controllerSegment';
          }
        } else {
          return '${PackageConstants.apiSegment}$controllerSegment';
        }
      } else {
        if (multiStoreUrl) {
          if (appRepoCubit.state.businessSelectBloc.state.isMultiStore) {
            return '${PackageConstants.apiSegment}$controllerSegment/${appRepoCubit.state.businessSelectBloc.state.selectedBusinessIdentity}/$apiSegment';
          } else {
            return '${PackageConstants.apiSegment}$controllerSegment/$apiSegment';
          }
        } else {
          return '${PackageConstants.apiSegment}$controllerSegment/$apiSegment';
        }
      }
    }
  }

  void _handleResponseException({required Response response}) {
    // print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        break;

      case 400:
        {
          if (response.body.runtimeType == String) {
            final ApiError apiError = ApiError.fromJson(
                jsonDecode(response.body) as Map<String, dynamic>);

            if (apiError.message != null) {
              throw AppException.fromString(apiError.message!);
            } else if (apiError.modelState != null) {
              if (apiError.modelState!.modelError != null) {
                if (apiError.modelState!.modelError!.isNotEmpty) {
                  throw AppException(
                    message: apiError.modelState!.modelError!,
                  );
                } else {
                  throw AppException.unknownHttpResponse(response.statusCode);
                }
              } else {
                throw AppException.unknownHttpResponse(response.statusCode);
              }
            } else if (apiError.errorDescription != null) {
              throw AppException.fromString(apiError.errorDescription!);
            } else {
              throw AppException.unknownHttpResponse(response.statusCode);
            }
          } else {
            throw AppException.unknownHttpResponse(response.statusCode);
          }
        }

      case 401:
        throw AppException.fromString(errorNotAuthorised);

      case 405:
        throw AppException.fromString(errorMethodNotAllowed);

      default:
        throw AppException.unknownHttpResponse(response.statusCode);
    }
  }

  void _handleRefreshTokenResponse({required Response response}) {
    switch (response.statusCode) {
      case 200:
        break;

      case 400:
        {
          appRepoCubit.state.appRepoAuthCubit.signOut([
            appRepoSignInTitle,
            appRepoSignInLine1,
            appRepoSignInline2,
          ]);
          throw AppException.fromString(errorNotAuthorised);
        }

      default:
        throw AppException(
            message: [errorUnknown, 'STATUS CODE: ${response.statusCode}']);
    }
  }

  Future<Map<String, String>> _defaultHeaders({
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    headers ??= <String, String>{};

    if (isForm) {
      headers.putIfAbsent(
          'Content-Type', () => 'application/x-www-form-urlencoded');
    } else {
      headers.putIfAbsent('Content-Type', () => 'application/json');

      if (await appRepoCubit.state.storageCubit.accessTokenExists()) {
        final accessToken =
            await appRepoCubit.state.storageCubit.getAccessToken();
        headers.putIfAbsent('Authorization', () => 'Bearer $accessToken');
      }
    }

    headers.putIfAbsent('accept', () => 'application/json');

    return headers;
  }

  Future<bool> _refreshAccessToken() async {
    if (!await appRepoCubit.state.storageCubit.refreshTokenExists()) {
      return false;
    }

    final String refreshToken =
        (await appRepoCubit.state.storageCubit.getRefreshToken())!;

    final Map<String, String> headers = <String, String>{};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    headers.putIfAbsent('accept', () => 'application/json');

    final Map<String, String> formData = {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
      'client_id': PackageConstants.clientId,
    };

    final Response response = await AppHttp().postFormData(
      Uri.https(PackageConstants.url, 'token'),
      formData,
      headers: headers,
    );

    _handleRefreshTokenResponse(response: response);

    final ServerToken serverToken = ServerToken.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );

    await appRepoCubit.state.storageCubit
        .saveAccessToken(serverToken.accessToken);

    await appRepoCubit.state.storageCubit
        .saveRefreshToken(serverToken.refreshToken);

    appRepoCubit.state.appRepoAuthCubit.updateServerToken(serverToken);

    return true;
  }

  Future<Response> httpGetWithCache({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
  }) async {
    final Map<String, String> headers = await _defaultHeaders();

    final File file = await AppCache().getSingleFile(
      _multiStoreUrl(
        controllerSegment: controllerSegment,
        apiSegment: apiSegment,
        multiStoreUrlOverride: multiStoreUrlOverride,
      ),
      headers: headers,
    );

    if (file.existsSync()) {
      return Response.bytes(await file.readAsBytes(), 200);
    } else {
      throw AppException.fromString(errorNotFound);
    }
  }

  Future<Response> httpGet({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
  }) async {
    late Response response;

    Map<String, String> headers = await _defaultHeaders();

    int authoriseAttempt = 0;
    bool authorised = false;
    while (authoriseAttempt <= maxAuthoriseAttempts && !authorised) {
      response = await AppHttp().get(
        Uri.https(
          PackageConstants.url,
          _multiStorePath(
            controllerSegment: controllerSegment,
            apiSegment: apiSegment,
            multiStoreUrlOverride: multiStoreUrlOverride,
          ),
        ),
        headers: headers,
      );

      if (response.statusCode == 401) {
        if (await _refreshAccessToken()) {
          headers = await _defaultHeaders();
          authoriseAttempt++;
        } else {
          break;
        }
      } else {
        authorised = true;
      }
    }

    _handleResponseException(response: response);

    return response;
  }

  Future<Response> httpHead({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
  }) async {
    late Response response;

    Map<String, String> headers = await _defaultHeaders();

    int authoriseAttempt = 0;
    bool authorised = false;
    while (authoriseAttempt <= maxAuthoriseAttempts && !authorised) {
      response = await AppHttp().head(
        Uri.https(
          PackageConstants.url,
          _multiStorePath(
            controllerSegment: controllerSegment,
            apiSegment: apiSegment,
            multiStoreUrlOverride: multiStoreUrlOverride,
          ),
        ),
        headers: headers,
      );

      if (response.statusCode == 401) {
        if (await _refreshAccessToken()) {
          headers = await _defaultHeaders();
          authoriseAttempt++;
        } else {
          break;
        }
      } else {
        authorised = true;
      }
    }

    _handleResponseException(response: response);

    return response;
  }

  Future<Response> httpPost({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
    Object? jsonObject,
    Encoding? encoding,
  }) async {
    late Response response;

    Map<String, String> headers = await _defaultHeaders();

    int authoriseAttempt = 0;
    bool authorised = false;

    while (authoriseAttempt <= maxAuthoriseAttempts && !authorised) {
      response = await AppHttp().post(
        Uri.https(
          PackageConstants.url,
          _multiStorePath(
            controllerSegment: controllerSegment,
            apiSegment: apiSegment,
            multiStoreUrlOverride: multiStoreUrlOverride,
          ),
        ),
        headers: headers,
        body: jsonEncode(jsonObject),
      );

      if (response.statusCode == 401) {
        if (await _refreshAccessToken()) {
          headers = await _defaultHeaders();
          authoriseAttempt++;
        } else {
          break;
        }
      } else {
        authorised = true;
      }
    }

    _handleResponseException(response: response);

    return response;
  }

  Future<Response> httpPut({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
    Object? jsonObject,
    Encoding? encoding,
  }) async {
    late Response response;

    Map<String, String> headers = await _defaultHeaders();

    int authoriseAttempt = 0;
    bool authorised = false;
    while (authoriseAttempt <= maxAuthoriseAttempts && !authorised) {
      response = await AppHttp().put(
        Uri.https(
          PackageConstants.url,
          _multiStorePath(
            controllerSegment: controllerSegment,
            apiSegment: apiSegment,
            multiStoreUrlOverride: multiStoreUrlOverride,
          ),
        ),
        headers: headers,
        body: jsonEncode(jsonObject),
      );

      if (response.statusCode == 401) {
        if (await _refreshAccessToken()) {
          headers = await _defaultHeaders();
          authoriseAttempt++;
        } else {
          break;
        }
      } else {
        authorised = true;
      }
    }

    _handleResponseException(response: response);

    return response;
  }

  Future<Response> httpPatch({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
    Object? jsonObject,
    Encoding? encoding,
  }) async {
    late Response response;

    Map<String, String> headers = await _defaultHeaders();

    int authoriseAttempt = 0;
    bool authorised = false;
    while (authoriseAttempt <= maxAuthoriseAttempts && !authorised) {
      response = await AppHttp().patch(
        Uri.https(
          PackageConstants.url,
          _multiStorePath(
            controllerSegment: controllerSegment,
            apiSegment: apiSegment,
            multiStoreUrlOverride: multiStoreUrlOverride,
          ),
        ),
        headers: headers,
        body: jsonEncode(jsonObject),
      );

      if (response.statusCode == 401) {
        if (await _refreshAccessToken()) {
          headers = await _defaultHeaders();
          authoriseAttempt++;
        } else {
          break;
        }
      } else {
        authorised = true;
      }
    }

    _handleResponseException(response: response);

    return response;
  }

  Future<Response> httpDelete({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
    Object? jsonObject,
    Encoding? encoding,
  }) async {
    late Response response;

    Map<String, String> headers = await _defaultHeaders();

    int authoriseAttempt = 0;
    bool authorised = false;
    while (authoriseAttempt <= maxAuthoriseAttempts && !authorised) {
      response = await AppHttp().delete(
        Uri.https(
          PackageConstants.url,
          _multiStorePath(
            controllerSegment: controllerSegment,
            apiSegment: apiSegment,
            multiStoreUrlOverride: multiStoreUrlOverride,
          ),
        ),
        headers: headers,
        body: jsonEncode(jsonObject),
      );

      if (response.statusCode == 401) {
        if (await _refreshAccessToken()) {
          headers = await _defaultHeaders();
          authoriseAttempt++;
        } else {
          break;
        }
      } else {
        authorised = true;
      }
    }

    _handleResponseException(response: response);

    return response;
  }

  Future<String> httpRead({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
  }) async {
    return AppHttp().read(
      Uri.https(
        PackageConstants.url,
        _multiStorePath(
          controllerSegment: controllerSegment,
          apiSegment: apiSegment,
          multiStoreUrlOverride: multiStoreUrlOverride,
        ),
      ),
      headers: await _defaultHeaders(),
    );
  }

  Future<Uint8List> httpReadBytes({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
  }) async {
    return AppHttp().readBytes(
      Uri.https(
        PackageConstants.url,
        _multiStorePath(
          controllerSegment: controllerSegment,
          apiSegment: apiSegment,
          multiStoreUrlOverride: multiStoreUrlOverride,
        ),
      ),
      headers: await _defaultHeaders(),
    );
  }

  Future<Response> httpPostFormDataWithoutApiSegment({
    required String urlSegment,
    required Map<String, String> formData,
  }) async {
    final Map<String, String> headers = await _defaultHeaders(isForm: true);

    final Response response = await AppHttp().postFormData(
      Uri.https(PackageConstants.url, urlSegment),
      formData,
      headers: headers,
    );

    _handleResponseException(response: response);

    return response;
  }

  Future<Map<String, dynamic>> httpGetJsonDecode({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
  }) async {
    final response = await httpGet(
      controllerSegment: controllerSegment,
      apiSegment: apiSegment,
      multiStoreUrlOverride: multiStoreUrlOverride,
    );

    if (response.body.isEmpty) {
      return <String, dynamic>{};
    } else {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
  }

  Future<List<Map<String, dynamic>>> httpGetJsonDecodeList({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
  }) async {
    final response = await httpGet(
      controllerSegment: controllerSegment,
      apiSegment: apiSegment,
      multiStoreUrlOverride: multiStoreUrlOverride,
    );

    return (jsonDecode(response.body) as List)
        .map((dynamic e) => e as Map<String, dynamic>)
        .toList();
  }

  Future<List<T>> httpGetJsonDecodeListModel<T>({
    required String controllerSegment,
    required String? apiSegment,
    required T Function(Map<String, dynamic>) fromJson,
    bool multiStoreUrlOverride = false,
  }) async {
    final response = await httpGet(
      controllerSegment: controllerSegment,
      apiSegment: apiSegment,
      multiStoreUrlOverride: multiStoreUrlOverride,
    );

    return (jsonDecode(response.body) as List)
        .map((dynamic e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<T>> httpGetWithCacheJsonDecodeListModel<T>({
    required String controllerSegment,
    required String? apiSegment,
    required T Function(Map<String, dynamic>) fromJson,
    bool multiStoreUrlOverride = false,
  }) async {
    final response = await httpGetWithCache(
      controllerSegment: controllerSegment,
      apiSegment: apiSegment,
      multiStoreUrlOverride: multiStoreUrlOverride,
    );

    return (jsonDecode(response.body) as List)
        .map((dynamic e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Map<String, dynamic>> httpPostFormDataWithoutApiSegmentJsonDecode({
    required String urlSegment,
    required Map<String, String> formData,
  }) async {
    final response = await httpPostFormDataWithoutApiSegment(
      urlSegment: urlSegment,
      formData: formData,
    );

    if (response.body.isEmpty) {
      return <String, dynamic>{};
    } else {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
  }

  Future<Map<String, dynamic>> httpPostJsonDecode({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
    Object? jsonObject,
    Encoding? encoding,
  }) async {
    final response = await httpPost(
      controllerSegment: controllerSegment,
      apiSegment: apiSegment,
      multiStoreUrlOverride: multiStoreUrlOverride,
      jsonObject: jsonObject,
      encoding: encoding,
    );

    if (response.body.isEmpty) {
      return <String, dynamic>{};
    } else {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
  }

  Future<List<T>> httpPostJsonDecodeListModel<T>({
    required String controllerSegment,
    required String? apiSegment,
    required T Function(Map<String, dynamic>) fromJson,
    bool multiStoreUrlOverride = false,
    Object? jsonObject,
    Encoding? encoding,
  }) async {
    final response = await httpPost(
      controllerSegment: controllerSegment,
      apiSegment: apiSegment,
      multiStoreUrlOverride: multiStoreUrlOverride,
      jsonObject: jsonObject,
      encoding: encoding,
    );
    return (jsonDecode(response.body) as List)
        .map((dynamic e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Map<String, dynamic>> httpPutJsonDecode({
    required String controllerSegment,
    required String? apiSegment,
    bool multiStoreUrlOverride = false,
    Object? jsonObject,
    Encoding? encoding,
  }) async {
    final response = await httpPut(
      controllerSegment: controllerSegment,
      apiSegment: apiSegment,
      multiStoreUrlOverride: multiStoreUrlOverride,
      jsonObject: jsonObject,
      encoding: encoding,
    );
    if (response.body.isEmpty) {
      return <String, dynamic>{};
    } else {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
  }

  Future<List<T>> httpPutJsonDecodeListModel<T>({
    required String controllerSegment,
    required String? apiSegment,
    required T Function(Map<String, dynamic>) fromJson,
    bool multiStoreUrlOverride = false,
    Object? jsonObject,
    Encoding? encoding,
  }) async {
    final response = await httpPut(
      controllerSegment: controllerSegment,
      apiSegment: apiSegment,
      multiStoreUrlOverride: multiStoreUrlOverride,
      jsonObject: jsonObject,
      encoding: encoding,
    );

    return (jsonDecode(response.body) as List)
        .map((dynamic e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
