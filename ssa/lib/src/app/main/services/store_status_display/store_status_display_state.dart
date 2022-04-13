import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class StoreStatusDisplayState extends Equatable {
  const StoreStatusDisplayState({
    required this.showBanner,
  });

  final bool showBanner;

  @override
  List<Object?> get props => [showBanner];
}

