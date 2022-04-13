import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/dart_define.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_cache.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/image/image_error_widget.dart';
import 'package:single_store_app/src/app/widgets/image/image_progress_widget.dart';
import 'package:single_store_app/src/app/widgets/image/no_image_widget.dart';

class SitemImageWidget extends StatelessWidget {
  const SitemImageWidget({
    required this.sysSitemId,
    required this.hasImage,
    Key? key,
  }) : super(key: key);

  final String sysSitemId;
  final bool hasImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 600),
      child: ClipRect(
        child: FittedBox(
          fit: BoxFit.cover,
          child: hasImage
              ? CachedNetworkImage(
                  width: 320,
                  height: 214,
                  imageUrl:
                      'https://${PackageConstants.webSiteUrl}/${context.read<BusinessSettingsBloc>().state.productImagePath}/$sysSitemId.jpg',
                  placeholder: (context, url) => const ImageProgressWidget(
                    size: Size(320, 214),
                  ),
                  errorWidget: (context, url, dynamic error) =>
                      ImageErrorWidget(
                    size: const Size(320, 214),
                    error: error,
                  ),
                  cacheManager: AppCache(),
                )
              : const NoImageWidget(
                  size: Size(320, 214),
                ),
        ),
      ),
    );
  }
}
