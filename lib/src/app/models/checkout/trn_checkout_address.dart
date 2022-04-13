
import 'package:single_store_app/src/app/models/checkout/user_billing_client.dart';

class TrnCheckoutAddress {
  TrnCheckoutAddress({
    required this.company,
    required this.companyNumber,
    required this.addressNote,
    required this.street,
    required this.extended,
    required this.locality,
    required this.region,
    required this.postalCode,
    required this.country,
    required this.lat,
    required this.lng,
    required this.distance,
  });

  TrnCheckoutAddress.fromUserBillingClient(UserBillingClient userBillingClient) :

      company = userBillingClient.company,
      companyNumber=  userBillingClient.companyNumber,
      addressNote=  userBillingClient.addressNote,
      street = userBillingClient.street!,
      extended = userBillingClient.extended,
      locality = userBillingClient.locality!,
      region = userBillingClient.region!,
      postalCode = userBillingClient.postalCode!,
      country = userBillingClient.country!,
      lat = userBillingClient.lat,
      lng = userBillingClient.lng,
      distance = userBillingClient.distance;

  final   String? company;
  final   String? companyNumber;
  final   String? addressNote;
  final   String street;
  final   String? extended;
  final   String locality;
  final   String region;
  final   String postalCode;
  final   String country;
  final   double? lat;
  final   double? lng;
  final   double? distance;


}
