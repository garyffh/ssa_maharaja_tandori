import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_state.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/ui/empty_widget.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

class UserCardView extends StatelessWidget {
  const UserCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        buildWhen: (previous, current) =>
            previous.isAuthenticated != current.isAuthenticated,
        builder: (context, state) {
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: SizedBox(
                height: constraints.maxHeight,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ViewTitleWidget(
                      title: 'Member Card',
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _view(context, state),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget _view(BuildContext viewContext, AuthenticationState state) {
    if (state is AuthenticationStateAuthenticated) {
      if (viewContext.watch<MediaSettingsBloc>().state.isMobile) {
        if (viewContext.watch<MediaSettingsBloc>().state.orientation ==
            Orientation.portrait) {
          return _card(viewContext, state);
        } else {
          return _landscapeMessage(viewContext);
        }
      } else {
        return _card(viewContext, state);
      }
    } else {
      return const EmptyWidget();
    }
  }

  Widget _card(
      BuildContext viewContext, AuthenticationStateAuthenticated state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: QrImage(
            data: state.cardNumber,
            version: QrVersions.auto,
            size: 320,
          ),
        ),
      ],
    );
  }

  Widget _landscapeMessage(BuildContext viewContext) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: viewContext.watch<MediaSettingsBloc>().state.sp(85)),
      child: Text(
        'Please adjust your device to portrait mode.',
        style: viewContext.watch<MediaSettingsBloc>().state.subtitle1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
