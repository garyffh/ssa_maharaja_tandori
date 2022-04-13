import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';

class GenericList<E> extends ListBase<E> {
  GenericList();

  @JsonKey(name: 'innerList')
  @GenericListConverter()
  List<E> innerList = <E>[];

  @override
  int get length => innerList.length;

  @override
  set length(int length) {
    innerList.length = length;
  }

  @override
  void operator []=(int index, E value) {
    innerList[index] = value;
  }

  @override
  E operator [](int index) => innerList[index];

  @override
  void add(E element) => innerList.add(element);

  @override
  void addAll(Iterable<E> iterable) => innerList.addAll(iterable);
}

class GenericListConverter<E> implements JsonConverter<E, Object> {
  const GenericListConverter();

  @override
  E fromJson(Object json) {
    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    return json as E;
  }

  @override
  Object toJson(E object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return Object;
  }
}
