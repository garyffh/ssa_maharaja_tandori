
enum FakeError { none, noInternet, endPointNotFound, invalidJson }

class FakeHttp {
  FakeHttp({this.fakeError = FakeError.none, this.duration = 500});

  final FakeError fakeError;
  final int duration;


}
