import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/repos/home/address_repo.dart';
import 'package:single_store_app/src/app/models/user/address_result.dart';
import 'package:single_store_app/src/app/models/user/suggest_address_result.dart';
import 'package:single_store_app/src/app/models/user/user_address.dart';
import 'package:single_store_app/src/app/models/user/validated_address_result.dart';

import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc({
    required this.addressRepo,
  }) : super(AddressStateInitial()) {
    on<AddressEventQuery>((event, emit) async {
      emit(AddressStateProgressError());

      try {
        final String query = event.query.trim();

        if (query.length > 3) {
          final SuggestAddressResult suggestAddressResult =
              await addressRepo.readSuggestedAddresses(
            query: query,
          );
          if (suggestAddressResult.suggest != null) {
            emit(AddressStateResult(
              suggestAddresses: suggestAddressResult.suggest!,
            ));
          } else {
            emit(AddressStateQueryCommenced());
          }
        } else {
          emit(AddressStateQueryCommenced());
        }
      } catch (e) {
        emit(AddressStateProgressError(error: e));
      }
    });

    on<AddressEventValidate>((event, emit) async {
      emit(AddressStateProgressError());

      try {
        final ValidatedAddressResult validatedAddressResult =
            await addressRepo.validateAddress(
          id: event.suggestAddress.id,
        );

        emit(AddressStateValidated(
            address: AddressResult(
          street: validatedAddressResult.address.street,
          extended: validatedAddressResult.address.extended,
          locality: validatedAddressResult.address.locality,
          region: validatedAddressResult.address.region,
          postalCode: validatedAddressResult.address.postalCode,
          country: validatedAddressResult.address.country,
          lat: validatedAddressResult.address.lat,
          lng: validatedAddressResult.address.lng,
          distance: validatedAddressResult.address.distance,
        )));
      } catch (e) {
        emit(AddressStateProgressError(error: e));
      }
    });

    on<AddressEventSubmit>((event, emit) async {
      if (state is AddressStateSelected) {
        final AddressStateSelected stateSelected =
            state as AddressStateSelected;

        try {
          emit(AddressStateSubmitProgress(
            address: stateSelected.address,
          ));

          if (event.saveAddress) {
            final UserAddress currentAddress = await addressRepo.findAddress();

            await addressRepo.updateAddress(
              userAddress: UserAddress.fromSubmittedAddress(
                currentAddress.updateId,
                event.address,
              ),
            );
          }

          emit(AddressStateSubmitted(
            address: event.address,
          ));
        } catch (e) {
          emit(AddressStateSubmitProgress(
              address: stateSelected.address, error: e));
        }
      } else {
        emit(AddressStateProgressError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<AddressEventResetError>((event, emit) async {
      if (state is AddressStateSelected) {
        final AddressStateSelected stateSelected =
            state as AddressStateSelected;

        emit(AddressStateValidated(address: stateSelected.address));
      } else {
        emit(AddressStateInitial());
      }
    });

    on<AddressEventInitialise>((event, emit) async {
      emit(AddressStateInitial());
    });
  }

  final AddressRepo addressRepo;

}
