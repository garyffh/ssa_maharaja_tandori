import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';
import 'package:single_store_app/src/app/main/repos/authentication_repo.dart';
import 'package:single_store_app/src/app/main/services/app_firebase/app_firebase_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/repos/storage_repo.dart';
import 'package:single_store_app/src/app/services/app_audio/app_audio_state.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_cubit.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_state.dart';
import 'package:single_store_app/src/app/services/app_snack_bar/app_snack_bar_cubit.dart';
import 'package:single_store_app/src/app/services/app_theme/app_theme_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';

import 'app_firebase_messaging_event.dart';
import 'app_firebase_messaging_state.dart';

class AppFirebaseMessagingBloc
    extends Bloc<AppFirebaseMessagingEvent, AppFirebaseMessagingState> {
  AppFirebaseMessagingBloc({
    required this.storageRepo,
    required this.authenticationRepo,
    required this.appThemeBloc,
    required AppFirebaseBloc appFirebaseBloc,
    required this.authenticationBloc,
    required this.appMessagingCubit,
    required this.appSnackBarCubit,
    required this.businessSettingsBloc,
  }) : super(const AppFirebaseMessagingStateInitial()) {
    on<AppFirebaseMessagingEventConfigure>((event, emit) async {
      try {
        if (AppConstants.enabledMessagingPlatform) {
          emit(const AppFirebaseMessagingStateProgressError());

          final NotificationSettings authorization =
              await FirebaseMessaging.instance.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          );

          if (authorization.authorizationStatus ==
              AuthorizationStatus.authorized) {
            // channel = const AndroidNotificationChannel(
            //   'high_importance_channel', // id
            //   'High Importance Notifications', // title
            //   'This channel is used for important notifications.', // description
            //   importance: Importance.high,
            // );

            // if (defaultTargetPlatform == TargetPlatform.iOS) {
            //   final String? apnsToken =
            //       await FirebaseMessaging.instance.getAPNSToken();
            //
            // }

            final String? token = await FirebaseMessaging.instance.getToken();

            if (token != null) {
              await FirebaseMessaging.instance
                  .setForegroundNotificationPresentationOptions(
                alert: false,
                badge: false,
                sound: false,
              );

              _configureMessaging();

              final bool deviceUpdateSent =
                  authenticationBloc.state.isAuthenticated;

              if (authenticationBloc.state.isAuthenticated) {
                await authenticationRepo.deviceUpdate(token);
              }

              emit(AppFirebaseMessagingStateEnabled(
                token: token,
                deviceUpdateSent: deviceUpdateSent,
              ));
            } else {
              emit(const AppAppFirebaseMessagingStateDisabled());
            }
          } else {
            // not authorized
            emit(const AppAppFirebaseMessagingStateDisabled());
          }
        } else {
          // platform not enabled for messaging -> enabledMessagingPlatform
          emit(const AppAppFirebaseMessagingStateDisabled());
        }
      } catch (e) {
        emit(AppFirebaseMessagingStateProgressError(error: e));
      }
    });

    on<AppFirebaseMessagingEventDisable>((event, emit) async {
      emit(const AppAppFirebaseMessagingStateDisabled());
    });

    on<AppFirebaseMessagingEventDeviceUpdate>((event, emit) async {
      if (state is AppFirebaseMessagingStateEnabled) {
        final AppFirebaseMessagingStateEnabled
            appFirebaseMessagingStateEnabled =
            state as AppFirebaseMessagingStateEnabled;

        await authenticationRepo
            .deviceUpdate(appFirebaseMessagingStateEnabled.token);

        emit(AppFirebaseMessagingStateEnabled(
          token: appFirebaseMessagingStateEnabled.token,
          deviceUpdateSent: true,
        ));
      }
    });

    on<AppFirebaseMessagingEventDeviceDisable>((event, emit) async {
      if (state is AppFirebaseMessagingStateEnabled) {
        final AppFirebaseMessagingStateEnabled
            appFirebaseMessagingStateEnabled =
            state as AppFirebaseMessagingStateEnabled;

        emit(AppFirebaseMessagingStateEnabled(
          token: appFirebaseMessagingStateEnabled.token,
          deviceUpdateSent: false,
        ));
      }
    });

    appFirebaseBlocSubscription =
        appFirebaseBloc.stream.listen((appFirebaseState) {
      if (appFirebaseState.initialised) {
        if (appFirebaseState.enabled) {
          add(AppFirebaseMessagingEventConfigure());
        } else {
          add(AppFirebaseMessagingEventDisable());
        }
      }
    });

    authenticationBlocSubscription =
        authenticationBloc.stream.listen((authenticationState) {
      if (authenticationState.isAuthenticated) {
        if (state is AppFirebaseMessagingStateEnabled) {
          final AppFirebaseMessagingStateEnabled
              appFirebaseMessagingStateEnabled =
              state as AppFirebaseMessagingStateEnabled;
          if (!appFirebaseMessagingStateEnabled.deviceUpdateSent) {
            add(AppFirebaseMessagingEventDeviceUpdate());
          }
        }
      } else {
        if (state is AppFirebaseMessagingStateEnabled) {
          final AppFirebaseMessagingStateEnabled
              appFirebaseMessagingStateEnabled =
              state as AppFirebaseMessagingStateEnabled;
          if (appFirebaseMessagingStateEnabled.deviceUpdateSent) {
            add(AppFirebaseMessagingEventDeviceDisable());
          }
        }
      }
    });
  }

  final AuthenticationRepo authenticationRepo;
  final StorageRepo storageRepo;
  final AppThemeBloc appThemeBloc;
  final AuthenticationBloc authenticationBloc;
  final AppMessagingCubit appMessagingCubit;
  final AppSnackBarCubit appSnackBarCubit;
  final BusinessSettingsBloc businessSettingsBloc;

  late StreamSubscription appFirebaseBlocSubscription;
  late StreamSubscription authenticationBlocSubscription;

  String get businessName =>
      (businessSettingsBloc.state as BusinessSettingsStateLoaded).businessName;

  @override
  Future<void> close() {
    authenticationBlocSubscription.cancel();
    appFirebaseBlocSubscription.cancel();
    return super.close();
  }

  void _configureMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {

      final AppMessagingPublished? appMessagingPublished =
          _buildAppMessage(event);

      if (appMessagingPublished == null) {
        return;
      }

      if (appMessagingPublished.messageId == null) {
        return;
      }

      if (appMessagingPublished.method == null) {
        return;
      }

      if (appMessagingPublished.method == 'localMessage') {
        if (appMessagingPublished.body != null) {
          await appSnackBarCubit.showSnackBar(
              snackBar: SnackBar(content: Text(appMessagingPublished.body!)));
        }
      } else {
        switch (appMessagingPublished.method) {
          case 'TrnOrderPrepareUpdateDriver':
          case 'TrnOrderCancelUpdateDriver':
          case 'TrnOrderDispatchUpdateDriver':
          case 'TrnOrderDispatchUpdateUser':
          case 'TrnOrderPickupUpdateUser':
          case 'TrnOrderCancelUpdateUser':
          case 'TrnOrderDriveUpdateUser':
          case 'TrnOrderDeliveryUpdateUser':
          case 'TrnOrderQueueUpdateUser':
            {
              appMessagingCubit.publishTrnOrderUpdate(
                message:
                    AppMessagingTrnOrderUpdate.copyWith(appMessagingPublished),
              );

              break;
            }

          case 'TrnOrderAllocateDriverUser':
            {
              await appSnackBarCubit.showSnackBar(
                  snackBar: const SnackBar(
                      content: Text(
                          'Your order has been allocated a delivery driver')),
                  appSound: AppSound.message);

              appMessagingCubit.publishTrnOrderUserAllocateDriver(
                message: AppMessagingTrnOrderUserAllocateDriver.copyWith(
                    appMessagingPublished),
              );

              break;
            }

          case 'TrnOrderAllocateDriverDriver':
            {
              await appSnackBarCubit.showSnackBar(
                  snackBar:
                      SnackBar(content: Text('New $businessName delivery')),
                  appSound: AppSound.driverDelivery);

              appMessagingCubit.publishMessage(
                message: appMessagingPublished,
              );

              break;
            }

          default:
            {
              appMessagingCubit.publishMessage(
                message: appMessagingPublished,
              );
              break;
            }
        }
      }
    });
  }

  AppMessagingPublished? _buildAppMessage(RemoteMessage event) {
    if (event.data == null) {
      return null;
    }
    if (!event.data.containsKey('method')) {
      return null;
    }

    return (event.notification == null)
        ? AppMessagingPublished(
            method: event.data['method'] as String,
            messageId: event.messageId,
            messageType: event.messageType,
            sentTime: event.sentTime,
            ttl: event.ttl,
            from: event.from,
            title: null,
            body: null,
            data: event.data,
          )
        : AppMessagingPublished(
            method: event.data['method'] as String,
            messageId: event.messageId,
            messageType: event.messageType,
            sentTime: event.sentTime,
            ttl: event.ttl,
            from: event.from,
            title: event.notification!.title,
            body: event.notification!.body,
            data: event.data,
          );
  }
}

// FirebaseMessaging.onMessageOpenedApp.listen((message) {
//   print('Message clicked!');
// });

// _firebaseMessaging.configure(
//   onLaunch: (Map<String, dynamic> message) {
//     print('onLaunch called');
//   },
//   onResume: (Map<String, dynamic> message) {
//     print('onResume called');
//   },
//   onMessage: (Map<String, dynamic> message) {
//     print('onMessage called');
//   },
// );
// _firebaseMessaging.subscribeToTopic('all');
// _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
//   sound: true,
//   badge: true,
//   alert: true,
// ));
// _firebaseMessaging.onIosSettingsRegistered
//     .listen((IosNotificationSettings settings) {
//   print('Hello');
// });
