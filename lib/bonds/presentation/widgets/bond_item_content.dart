import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:ultra/bonds/data/models/bond_item_model.dart';
import 'package:ultra/bonds/presentation/widgets/image_loader_widget.dart';
import 'package:ultra/gen/assets.gen.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/app_text_styles.dart';
import 'package:ultra/utils/num_extensions.dart';

class BondItemContent extends StatelessWidget {
  final BondItem item;
  final List<String> search;
  const BondItemContent({super.key, required this.item, required this.search});

  @override
  Widget build(BuildContext context) {
    final isINSmallSpans = <TextSpan>[];
    final titleSmall =
        item.isin.substring(0, item.isin.length - 4).toUpperCase();
    final titleBig = item.isin.substring(item.isin.length - 4).toUpperCase();

    //searching in isin small
    if (search.isNotEmpty) {
      bool matched = false;
      for (String word in search) {
        final wordLowerCase = word.toLowerCase();
        if (wordLowerCase.isEmpty) continue;
        final matches =
            wordLowerCase.allMatches(titleSmall.toLowerCase()).toList();
        if (matches.isNotEmpty) {
          matched = true;
          for (int i = 0; i < matches.length; i++) {
            final strStart = i == 0 ? 0 : matches[i - 1].end;
            final match = matches[i];
            isINSmallSpans.add(
              TextSpan(
                text: titleSmall.substring(strStart, match.start).toUpperCase(),
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
            );
            isINSmallSpans.add(
              TextSpan(
                text:
                    titleSmall.substring(match.start, match.end).toUpperCase(),
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.textGrey,
                  backgroundColor: AppColors.searchMatch,
                ),
              ),
            );
          }
          isINSmallSpans.add(
            TextSpan(
              text: titleSmall.substring(matches.last.end).toUpperCase(),
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.textGrey,
              ),
            ),
          );
        }
      }
      if (!matched) {
        isINSmallSpans.add(
          TextSpan(
            text: titleSmall,
            style: AppTextStyles.titleSmall.copyWith(color: AppColors.textGrey),
          ),
        );
      }
    } else {
      isINSmallSpans.add(
        TextSpan(
          text: titleSmall,
          style: AppTextStyles.titleSmall.copyWith(color: AppColors.textGrey),
        ),
      );
    }

    final isINBigSpans = <TextSpan>[];

    //searching in isin big, i.e. 1234
    if (search.isNotEmpty) {
      bool matched = false;
      for (String word in search) {
        final wordLowerCase = word.toLowerCase();
        if (wordLowerCase.isEmpty) continue;
        final matches =
            wordLowerCase.allMatches(titleBig.toLowerCase()).toList();
        if (matches.isNotEmpty) {
          matched = true;
          for (int i = 0; i < matches.length; i++) {
            final strStart = i == 0 ? 0 : matches[i - 1].end;
            final match = matches[i];
            isINBigSpans.add(
              TextSpan(
                text: titleBig.substring(strStart, match.start).toUpperCase(),
                style: AppTextStyles.titleBig.copyWith(
                  color: AppColors.ebitdaBlack,
                ),
              ),
            );
            isINBigSpans.add(
              TextSpan(
                text: titleBig.substring(match.start, match.end).toUpperCase(),
                style: AppTextStyles.titleBig.copyWith(
                  color: AppColors.ebitdaBlack,
                  backgroundColor: AppColors.searchMatch,
                ),
              ),
            );
          }
          isINBigSpans.add(
            TextSpan(
              text: titleBig.substring(matches.last.end).toUpperCase(),
              style: AppTextStyles.titleBig.copyWith(
                color: AppColors.ebitdaBlack,
              ),
            ),
          );
        }
      }
      if (!matched) {
        isINBigSpans.add(
          TextSpan(
            text: titleBig,
            style: AppTextStyles.titleBig.copyWith(
              color: AppColors.ebitdaBlack,
            ),
          ),
        );
      }
    } else {
      isINBigSpans.add(
        TextSpan(
          text: titleBig,
          style: AppTextStyles.titleBig.copyWith(color: AppColors.ebitdaBlack),
        ),
      );
    }

    //searching in name
    final nameSpans = <TextSpan>[];
    if (search.isNotEmpty) {
      bool matched = false;
      // for (String word in search) {
      final matches = <Match>[];
      for (String word in search) {
        final wordLowerCase = word.toLowerCase();
        if (wordLowerCase.isEmpty) continue;
        matches.addAll(
          wordLowerCase.allMatches(item.name.toLowerCase()).toList(),
        );
      }

      if (matches.isNotEmpty) {
        matched = true;
        for (int i = 0; i < matches.length; i++) {
          final strStart = i == 0 ? 0 : matches[i - 1].end;
          final match = matches[i];
          if (match.start > strStart) {
            nameSpans.add(
              TextSpan(
                text: item.name.substring(strStart, match.start),
                style: AppTextStyles.body.copyWith(color: AppColors.textGrey),
              ),
            );
          }
          nameSpans.add(
            TextSpan(
              text: item.name.substring(match.start, match.end),
              style: AppTextStyles.body.copyWith(
                color: AppColors.textGrey,
                backgroundColor: AppColors.searchMatch,
              ),
            ),
          );
        }
        nameSpans.add(
          TextSpan(
            text: item.name.substring(matches.last.end),
            style: AppTextStyles.body.copyWith(color: AppColors.textGrey),
          ),
        );
        // }
      }
      if (!matched) {
        nameSpans.add(
          TextSpan(
            text: item.name,
            style: AppTextStyles.body.copyWith(color: AppColors.textGrey),
          ),
        );
      }
    } else {
      nameSpans.add(
        TextSpan(
          text: item.name,
          style: AppTextStyles.body.copyWith(color: AppColors.textGrey),
        ),
      );
    }

    return InkWell(
      onTap: () {
        HapticFeedback.heavyImpact();
        context.go("/bond-details");
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
                fadeInDuration: 200.ms,
                fadeOutDuration: 200.ms,
                placeholder:
                    (context, url) => ImageLoaderWidget(addPadding: false),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            10.sw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text.rich(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(children: isINSmallSpans),
                      ),
                      2.sw,
                      Text.rich(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(children: isINBigSpans),
                      ),
                    ],
                  ),
                  2.sh,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${item.rating} •',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textGrey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      4.sw,
                      Text.rich(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(children: nameSpans),
                      ),
                    ],
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
