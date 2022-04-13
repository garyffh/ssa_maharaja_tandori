import 'package:json_annotation/json_annotation.dart';

import 'condiment_table.dart';

part 'condiment_chain.g.dart';

@JsonSerializable()
class CondimentChain {
  CondimentChain({
    required this.sysCondimentChainId,
    required this.number,
    required this.name,
    required this.condimentTables,
  });

  factory CondimentChain.fromJson(Map<String, dynamic> json) =>
      _$CondimentChainFromJson(json);

  Map<String, dynamic> toJson() => _$CondimentChainToJson(this);

  final String sysCondimentChainId;
  final int number;
  final String name;
  final List<CondimentTable> condimentTables;
}
