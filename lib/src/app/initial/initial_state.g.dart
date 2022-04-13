// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitialStateLoaded _$InitialStateLoadedFromJson(Map<String, dynamic> json) =>
    InitialStateLoaded(
      applicationName: json['applicationName'] as String,
      theme: json['theme'] as String,
      newAccounts: json['newAccounts'] as bool,
      signInRequired: json['signInRequired'] as bool,
      hasEnterpriseApp: json['hasEnterpriseApp'] as bool,
      isMultiStore: json['isMultiStore'] as bool,
      stores: (json['stores'] as List<dynamic>)
          .map((e) => InitialStore.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InitialStateLoadedToJson(InitialStateLoaded instance) =>
    <String, dynamic>{
      'applicationName': instance.applicationName,
      'theme': instance.theme,
      'newAccounts': instance.newAccounts,
      'signInRequired': instance.signInRequired,
      'hasEnterpriseApp': instance.hasEnterpriseApp,
      'isMultiStore': instance.isMultiStore,
      'stores': instance.stores,
    };
