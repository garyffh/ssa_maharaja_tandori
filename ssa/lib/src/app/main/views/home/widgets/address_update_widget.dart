import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';
import 'package:single_store_app/src/app/main/services/address/address_bloc.dart';
import 'package:single_store_app/src/app/main/services/address/address_event.dart';
import 'package:single_store_app/src/app/main/services/address/address_state.dart';
import 'package:single_store_app/src/app/models/user/address_result.dart';
import 'package:single_store_app/src/app/models/user/user_address.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/column_builder.dart';
import 'package:single_store_app/src/app/widgets/ui/search_widget.dart';

import 'address_note_widget.dart';

class AddressUpdateWidget extends StatefulWidget {
  const AddressUpdateWidget({
    this.onValidateAddress,
    this.onSubmitAddress,
    required this.saveAddress,
    required this.showCompany,
    Key? key,
  }) : super(key: key);

  final void Function(AddressResult address)? onValidateAddress;
  final void Function(UserAddress address)? onSubmitAddress;
  final bool saveAddress;
  final bool showCompany;

  @override
  State<AddressUpdateWidget> createState() => _AddressUpdateWidgetState();
}

class _AddressUpdateWidgetState extends State<AddressUpdateWidget> {
  bool _initialised = false;
  late AddressBloc addressBloc;

  String query = '';
  Timer? debounceTimer;

  @override
  void didChangeDependencies() {
    final addressBloc = BlocProvider.of<AddressBloc>(context);

    if (!_initialised) {
      _initialised = true;
      this.addressBloc = addressBloc;
      this.addressBloc.add(AddressEventInitialise());
    } else {
      if (this.addressBloc != addressBloc) {
        this.addressBloc = addressBloc;
        this.addressBloc.add(AddressEventInitialise());
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressBloc, AddressState>(
      listenWhen: (previous, current) =>
          current is AddressStateSubmitted || current is AddressStateValidated,
      listener: (context, state) {
        if (state is AddressStateSubmitted) {
          if (widget.onSubmitAddress != null) {
            widget.onSubmitAddress!(state.address);
          }
        } else if (state is AddressStateValidated) {
          if (widget.onValidateAddress != null) {
            widget.onValidateAddress!(state.address);
          }
        }
      },
      builder: (viewContext, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _view(viewContext, state),
        );
      },
    );
  }

  List<Widget> _view(BuildContext context, AddressState addressState) {

    switch (addressState.type) {
      case AddressProgressStateType.initial:
      case AddressProgressStateType.queryCommenced:
        {
          return [
            context.watch<MediaSettingsBloc>().state.padding,
            _search(),
          ];
        }

      case AddressProgressStateType.result:
        {
          return [
            context.watch<MediaSettingsBloc>().state.padding,
            _search(),
            _list(addressState),
            const SizedBox(height: 40.0),
          ];
        }

      case AddressProgressStateType.progressError:
        {
          return [
            context.watch<MediaSettingsBloc>().state.padding,
            _search(),
            FormProgressErrorWidget(
              progressFormView: addressState,
              progressText: '',
            ),
          ];
        }

      case AddressProgressStateType.validated:
      case AddressProgressStateType.submitProgress:
        {
          return [
            AddressNoteWidget(
              saveAddress: widget.saveAddress,
              showCompany: widget.showCompany,
            ),
          ];
        }

      case AddressProgressStateType.submitted:
        {
          return List.empty(growable: false);
        }
    }
  }

  Widget _search() => SearchWidget(
        text: query,
        hintText: 'start typing your address',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        addressBloc.add(AddressEventQuery(query: query));
        if (mounted) {
          setState(() {
            this.query = query;
          });
        }
      });

  void debounce(
    VoidCallback callback, {
    Duration duration =
        const Duration(milliseconds: AppConstants.debounceInterval),
  }) {
    if (debounceTimer != null) {
      debounceTimer!.cancel();
    }

    debounceTimer = Timer(duration, callback);
  }

  Widget _list(AddressState state) {
    return ColumnBuilder(
      itemCount: state.suggestAddresses.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: ListTile(
            title: Text(
              state.suggestAddresses[index].address,
              style: context.watch<MediaSettingsBloc>().state.bodyText1,
            ),
            onTap: () => addressBloc.add(AddressEventValidate(
                suggestAddress: state.suggestAddresses[index])),
            trailing: const Icon(
              Icons.navigate_next,
            ),
          ),
          onTap: () => addressBloc.add(AddressEventValidate(
            suggestAddress: state.suggestAddresses[index],
            saveAddress: widget.saveAddress,
          )),
        );
      },
    );

  }

  @override
  void dispose() {
    debounceTimer?.cancel();
    super.dispose();
  }
}
