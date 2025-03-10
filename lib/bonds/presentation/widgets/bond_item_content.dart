import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ultra/bonds/data/models/bond_item_model.dart';
import 'package:ultra/bonds/presentation/widgets/image_loader_widget.dart';
import 'package:ultra/gen/assets.gen.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/app_text_styles.dart';
import 'package:ultra/utils/num_extensions.dart';

class BondItemContent extends StatelessWidget {
  final BondItem item;
  const BondItemContent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final titleSmall =
        item.isin.substring(0, item.isin.length - 4).toUpperCase();
    final titleBig = item.isin.substring(item.isin.length - 4).toUpperCase();
    return InkWell(
      onTap: () {
        context.go("/bond-details");
        HapticFeedback.heavyImpact();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.grey, width: 0.5),
              ),
              child: CachedNetworkImage(
                imageUrl: item.logo,
                fadeInDuration: 200.milliseconds,
                fadeOutDuration: 200.milliseconds,
                placeholder: (context, url) => ImageLoaderWidget(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            10.sw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: titleSmall,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                        TextSpan(
                          text: titleBig,
                          style: AppTextStyles.titleBig.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  2.sh,
                  Text(
                    '${item.rating} • ${item.name}',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Assets.icons.icRight.svg(),
          ],
        ),
      ),
    );
  }
}
