import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/dart_define.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_cache.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/image/image_error_widget.dart';
import 'package:single_store_app/src/app/widgets/image/image_progress_widget.dart';

class SitemImageSmallWidget extends StatelessWidget {
  const SitemImageSmallWidget({required this.sitem, Key? key})
      : super(key: key);

  final Sitem sitem;

  @override
  Widget build(BuildContext context) {
    return (sitem.hasImage)
        ? CachedNetworkImage(
            width: 160,
            height: 107,
            imageUrl:
                'https://${PackageConstants.webSiteUrl}/${context.read<BusinessSettingsBloc>().state.productImagePath}/${sitem.sysSitemId}-small.jpg',
            placeholder: (context, url) => const ImageProgressWidget(
              size: Size(160, 107),
            ),
            errorWidget: (context, url, dynamic error) => ImageErrorWidget(
              size: const Size(160, 107),
              error: error,
            ),
            cacheManager: AppCache(),
          )
        : const SizedBox(
            width: 160,
            height: 107,
          );
  }
}
