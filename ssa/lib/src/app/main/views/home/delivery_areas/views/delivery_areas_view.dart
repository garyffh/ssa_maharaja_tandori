import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/dart_define.constants.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DeliveryAreasView extends StatefulWidget {
  const DeliveryAreasView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DeliveryAreasViewState();
}

class _DeliveryAreasViewState extends State<DeliveryAreasView> {
  bool _initialised = false;
  late bool isMobilePlatform;

  @override
  void didChangeDependencies() {
    final isMobilePlatform =
        context.watch<MediaSettingsBloc>().state.isMobilePlatform;

    if (!_initialised) {
      _initialised = true;
      this.isMobilePlatform = isMobilePlatform;
    } else {
      if (this.isMobilePlatform != isMobilePlatform) {
        this.isMobilePlatform = isMobilePlatform;
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

      return Column(
        children: [
          const ViewTitleWidget(
            title: 'Delivery Areas',
          ),
          Expanded(
            child: _view(context),
          ),
        ],
      );

  }

  Widget _view(BuildContext viewContext) {
    if (isMobilePlatform) {
      return _viewForm(viewContext);
    } else {
      return Center(
        child: Text(
          'Available on mobile platform!',
          style: context.watch<MediaSettingsBloc>().state.headline6,
        ),
      );
    }
  }

  Widget _viewForm(BuildContext viewContext) {
    return WebView(
      initialUrl: 'https://${PackageConstants.webSiteUrl}/${viewContext.read<BusinessSettingsBloc>().state.deliveryAreaPath}',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
