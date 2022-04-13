import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/text_style_extensions.dart';
import 'package:single_store_app/src/app/models/user/user_address.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/address/user_address_widget.dart';

class UserAddressEdit extends StatelessWidget {
  const UserAddressEdit({
    required this.userAddress,
    this.showCountry = true,
    this.onEdit,
    Key? key,
  }) : super(key: key);

  final UserAddress? userAddress;
  final bool showCountry;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.watch<MediaSettingsBloc>().state.sp10),
      child: Column(
        children: [
          ListTile(
            title: Padding(
              padding: EdgeInsets.only(
                  bottom: context.watch<MediaSettingsBloc>().state.sp8),
              child: Text(
                'Address',
                style: context.watch<MediaSettingsBloc>().state.subtitle2.bold,
              ),
            ),
            subtitle: UserAddressWidget(
              userAddress: userAddress,
              showCountry: showCountry,
            ),
            trailing: onEdit == null
                ? null
                : IconButton(
                    color: Theme.of(context).iconTheme.color,
                    iconSize: context.watch<MediaSettingsBloc>().state.sp20,
                    icon: const Icon(
                      Icons.edit,
                    ),
                    onPressed: () => onEdit!(),
                  ),
          ),
          const Divider(
            thickness: 3,
          ),
        ],
      ),
    );
  }
}
