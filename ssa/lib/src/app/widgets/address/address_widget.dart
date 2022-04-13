import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    this.company,
    this.companyNumber,
    required this.addressNote,
    required this.street,
    required this.extended,
    required this.locality,
    required this.region,
    required this.postalCode,
    required this.country,
    this.showCountry = true,
    Key? key,
  }) : super(key: key);

  final String? company;
  final String? companyNumber;
  final String? addressNote;
  final String street;
  final String? extended;
  final String locality;
  final String region;
  final String postalCode;
  final String country;
  final bool showCountry;

  @override
  Widget build(BuildContext context) {
    context.watch<MediaSettingsBloc>().state.bodyText1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (company != null && company!.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(
                vertical: context.watch<MediaSettingsBloc>().state.sp4),
            child: Text(
              company!,
              style: context.watch<MediaSettingsBloc>().state.bodyText1,
            ),
          ),
        if (companyNumber != null && companyNumber!.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(
                vertical: context.watch<MediaSettingsBloc>().state.sp4),
            child: Text(
              '(${companyNumber!})',
              style: context.watch<MediaSettingsBloc>().state.bodyText1,
            ),
          ),

        if (addressNote != null && addressNote!.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(
                vertical: context.watch<MediaSettingsBloc>().state.sp4),
            child: Text(
              addressNote!,
              style: context.watch<MediaSettingsBloc>().state.bodyText1,
            ),
          ),
        if (extended != null && extended!.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(
                vertical: context.watch<MediaSettingsBloc>().state.sp4),
            child: Text(
              extended!,
              style: context.watch<MediaSettingsBloc>().state.bodyText1,
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: context.watch<MediaSettingsBloc>().state.sp4),
          child: Text(
            street,
            style: context.watch<MediaSettingsBloc>().state.bodyText1,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: context.watch<MediaSettingsBloc>().state.sp4),
          child: Text(
            locality,
            style: context.watch<MediaSettingsBloc>().state.bodyText1,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: context.watch<MediaSettingsBloc>().state.sp4),
          child: Text(
            '$region $postalCode',
            style: context.watch<MediaSettingsBloc>().state.bodyText1,
          ),
        ),
        if (showCountry)
          Container(
            padding: EdgeInsets.symmetric(
                vertical: context.watch<MediaSettingsBloc>().state.sp4),
            child: Text(
              country,
              style: context.watch<MediaSettingsBloc>().state.bodyText1,
            ),
          ),
      ],
    );
  }
}
