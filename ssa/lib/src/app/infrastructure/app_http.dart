import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AppHttp {
  factory AppHttp() {
    return _instance;
  }

  AppHttp._({required this.client});

  static final AppHttp _instance = AppHttp._(client: http.Client());
  final Client client;

  Future<Response> get(Uri url, {Map<String, String>? headers}) =>
      _withClient((client) => client.get(url, headers: headers));

  Future<Response> head(Uri url, {Map<String, String>? headers}) =>
      _withClient((client) => client.head(url, headers: headers));

  Future<Response> post(Uri url,
          {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      _withClient((client) =>
          client.post(url, headers: headers, body: body, encoding: encoding));

  Future<Response> put(Uri url,
          {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      _withClient((client) =>
          client.put(url, headers: headers, body: body, encoding: encoding));

  Future<Response> patch(Uri url,
          {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      _withClient((client) =>
          client.patch(url, headers: headers, body: body, encoding: encoding));

  Future<Response> delete(Uri url,
          {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      _withClient((client) =>
          client.delete(url, headers: headers, body: body, encoding: encoding));

  Future<String> read(Uri url, {Map<String, String>? headers}) =>
      _withClient((client) => client.read(url, headers: headers));

  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) =>
      _withClient((client) => client.readBytes(url, headers: headers));

  Future<Response> postFormData(
    Uri url,
    Map<String, String> formData, {
    Map<String, String>? headers,
  }) async {

    final List<String> bodyParts = [];
    formData.forEach((key, value) {
      bodyParts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });

    final Response response = await _withClient(
      (client) => client.post(url, headers: headers, body: bodyParts.join('&')),
    );

    return response;
  }

  Future<T> _withClient<T>(Future<T> Function(Client) fn) async {
    try {
      return await fn(_instance.client);
    } finally {}
  }
}
