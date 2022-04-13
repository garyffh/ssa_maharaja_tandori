import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/dart_define.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_cache.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/image/image_error_widget.dart';
import 'package:single_store_app/src/app/widgets/image/image_progress_widget.dart';

class BannerImageWidget extends StatelessWidget {
  const BannerImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1024 x 270
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: 126),
      child: ClipRect(
        child: FittedBox(
          fit: BoxFit.cover,
          child: CachedNetworkImage(
            width: 1024,
            height: 270,
            imageUrl:
                'https://${PackageConstants.webSiteUrl}/${context.read<BusinessSettingsBloc>().state.imagesPath}/banner1.jpg',
            placeholder: (context, url) => const ImageProgressWidget(
              size: Size(1024, 270),
            ),
            errorWidget: (context, url, dynamic error) => ImageErrorWidget(
              size: const Size(1024, 270),
              error: error,
            ),
            cacheManager: AppCache(),
          ),
        ),
      ),
    );
  }
}
