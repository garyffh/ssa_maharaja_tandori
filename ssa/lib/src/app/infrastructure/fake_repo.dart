

import 'dart:convert';
import 'dart:io';
import 'fake_http.dart';

abstract class FakeRepo {
  FakeRepo({this.json = '{"dummy":"DUMMY"}'});

  final String json;

  Future<Map<String, dynamic>> httpGetJsonDecode(
      FakeHttp fakeHttp,
      ) async {
    await Future<dynamic>.delayed(Duration(milliseconds: fakeHttp.duration));

    switch (fakeHttp.fakeError) {
      case FakeError.noInternet:
        {
          throw const SocketException('No Internet');
        }

      case FakeError.endPointNotFound:
        {
          throw const HttpException('404');
        }

      case FakeError.invalidJson:
        {
          return jsonDecode('fakeJson') as Map<String, dynamic>;
        }

      default:
        {
          return jsonDecode(json) as Map<String, dynamic>;
        }
    }
  }


}

