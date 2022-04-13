import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

import 'initial_state.dart';

// class InitialFakeRepo extends FakeRepo {
//   InitialFakeRepo()
//       : super(
//           json:
//               '{"businessName":"Hub Cafe","companyNumber":"12345678901","taxRate":10.0000,"phone":"1300444555","email":"info@freeflowhub.com.au","contactUsEmail":"support@freeflowhub.com.au","smsTitle":"hubCafe","street":"2 KEELENDI ROAD","extended":"","locality":"WEST PENNANT HILLS","region":"NSW","postalCode":"2125","country":"Australia","latitude":-33.738535270,"longitude":151.053904300,"timeZone":"Australia/Sydney","minOrder":20.0000,"deliveryFee":12.0000,"minimumEftpos":0.0000,"tableService":true,"paymentKey":"pk_test_Zg7xoyYcmeFPRYaEzmZAVawy","googleApiKey":null,"deliveryDistance":4.500,"topMenuCategories":6,"priceLevel":1,"pointRedemptionRatio":10,"cardReadTypeId":0,"theme":"purple","newAccounts":true,"promoRate":10.0000,"deliveryPromoEnabled":false,"useDeliveryPeriods":true,"signInRequired":false,"storeStatus":{"storeTimes":{"type":0,"times":[{"typeId":0,"dayId":3,"fromTime":"2021-07-21T09:00:00","toTime":"2021-07-21T17:00:00","orderBefore":0,"store":true,"delivery":false,"period":false,"closed":false}],"openStatus":2},"deliveryTimes":{"type":1,"times":[],"openStatus":0},"periodTimes":{"type":3,"times":[{"typeId":2,"dayId":4,"fromTime":"2021-07-22T09:00:00","toTime":"2021-07-22T17:00:00","orderBefore":60,"store":false,"delivery":false,"period":true,"closed":false},{"typeId":2,"dayId":1,"fromTime":"2021-07-26T09:00:00","toTime":"2021-07-26T17:00:00","orderBefore":0,"store":false,"delivery":false,"period":true,"closed":false},{"typeId":2,"dayId":2,"fromTime":"2021-07-27T09:00:00","toTime":"2021-07-27T17:00:00","orderBefore":0,"store":false,"delivery":false,"period":true,"closed":false}],"openStatus":2},"openStatus":0,"statusTime":"2021-07-21T00:50:00","storeState":{"storeAvailable":true,"deliveryAvailable":true,"manualStoreOnline":true,"manualDeliveryOnline":true,"storeOnline":true,"driverAvailable":true,"storePrepTime":30,"storeLiveTime":20,"driverDeliveryTime":15,"driverLiveTime":10,"messageTitle":"FOLLOW US ON FACBOOK","message":"We take the care to source only the finest quality produce ..."}},"storeDeliveryZones":[{"storeDeliveryZoneId":"7ca36d0d-085d-4322-8479-bf0b4db05ba9","name":"Zone 1","number":1,"deliveryDistance":0.500,"deliveryFee":0.0000,"deliveryCost":5.0000,"walk":false,"bicycle":false,"drive":true},{"storeDeliveryZoneId":"f0d474e0-ed4b-4da2-9664-f4b1b9abc512","name":"Zone 2","number":2,"deliveryDistance":2.000,"deliveryFee":6.0000,"deliveryCost":8.0000,"walk":false,"bicycle":false,"drive":true},{"storeDeliveryZoneId":"764236a1-fd17-4616-98ca-1d60c0014e23","name":"Zone 3","number":3,"deliveryDistance":5.000,"deliveryFee":10.0000,"deliveryCost":12.0000,"walk":false,"bicycle":false,"drive":true}],"storeCategories":[{"sysStoreCategoryId":"b5c3c3c0-215e-430b-8145-f7d0946a65d5","number":1,"name":"Favourites"},{"sysStoreCategoryId":"fbfdc6ab-a799-44bc-983b-f25e5433b0af","number":2,"name":"Coffee"},{"sysStoreCategoryId":"7796c189-a980-489e-b308-20b9b45f186a","number":3,"name":"Hot Drinks"},{"sysStoreCategoryId":"2501ba29-e923-428d-9592-c1d388b20649","number":4,"name":"All Day Breakfast"},{"sysStoreCategoryId":"c3601639-74c6-4fdf-9f01-a3a82771d26d","number":5,"name":"Rolls"},{"sysStoreCategoryId":"cfe4c8f7-a05b-430e-96a1-5d6eeb4d896d","number":6,"name":"Burgers"},{"sysStoreCategoryId":"b690dc2d-adac-4a7b-a770-747925141d9e","number":7,"name":"Sides"},{"sysStoreCategoryId":"1e10daf6-4975-4c23-be12-7afaadb6bbe6","number":8,"name":"Desserts"},{"sysStoreCategoryId":"9c703072-6ff3-4717-b925-aca7bf31755c","number":9,"name":"Cold Drinks"}]}',
//         );
// }

class InitialRepo extends AppRepo {
  InitialRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: false,
        );

  // Future<InitialStateLoaded> getServerBusinessSettings(
  //     {bool consolePrint = false}) async {
  //   return InitialStateLoaded.fromJson(
  //     await httpGetJsonDecode(
  //         apiSegment: 'business-settings',),
  //   );
  // }

  Future<InitialStateLoaded> getServerMultiStoreSettings(
      {bool consolePrint = false}) async {
    // await Future<dynamic>.delayed(const Duration(milliseconds: 10000));

    return InitialStateLoaded.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'multi-store',
        apiSegment: null,
      ),
    );
  }

// Future<InitialStateLoaded> fakeGetServerBusinessSettings(
//     FakeHttp fakeHttp) async {
//   return InitialStateLoaded.fromJson(
//     await InitialFakeRepo().httpGetJsonDecode(fakeHttp),
//   );
// }
}
