import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/quill_css.constants.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/privacy_policy_repo.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/view/primary_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'privacy_policy_bloc.dart';
import 'privacy_policy_event.dart';
import 'privacy_policy_state.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrivacyPolicyBloc(
        privacyPolicyRepo: context.read<PrivacyPolicyRepo>(),
      )..add(PrivacyPolicyEventGetViewModel()),
      child: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
        builder: (viewContext, state) {
          return PrimaryView(
            title: 'Privacy Policy',
            child: _view(viewContext, state),
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, PrivacyPolicyState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as PrivacyPolicyStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<PrivacyPolicyBloc>()
                .add(PrivacyPolicyEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.progressError:
      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
    BuildContext context,
    PrivacyPolicyStateViewModel viewModel,
  ) {
    return
      // kIsWeb
      //   ? const Text('PLACEHOLDER')
      //   :
    WebView(
            initialUrl: 'about:blank',
            onWebViewCreated: (WebViewController webViewController) {
              webViewController.loadUrl(
                Uri.dataFromString(quillCss + viewModel.privacyPolicyText.text,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('utf-8'))
                    .toString(),
              );
            },
          );
  }
}
