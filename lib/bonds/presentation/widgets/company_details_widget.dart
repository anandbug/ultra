import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ultra/bonds/data/models/company_details_model.dart';
import 'package:ultra/bonds/presentation/widgets/image_loader_widget.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/app_text_styles.dart';
import 'package:ultra/utils/num_extensions.dart';

class CompanyDetailsWidget extends StatelessWidget {
  final CompanyDetailsModel data;
  const CompanyDetailsWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.grey, width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.06),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: CachedNetworkImage(
              fadeInDuration: 200.milliseconds,
              fadeOutDuration: 200.milliseconds,
              imageUrl: data.logo,
              placeholder: (context, url) => ImageLoaderWidget(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          12.sh,
          Text(
            data.companyName,
            style: AppTextStyles.companyTitle.copyWith(color: AppColors.black),
          ),
          12.sh,
          Text(
            data.description,
            style: AppTextStyles.textField.copyWith(color: AppColors.bodyGrey),
          ),
          12.sh,
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.blue.withValues(alpha: 0.08),
                ),
                child: Text(
                  ("ISIN: ${data.isin}").toUpperCase(),
                  style: AppTextStyles.pillsText.copyWith(
                    color: AppColors.blue,
                  ),
                ),
              ),
              16.sw,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.green.withValues(alpha: 0.12),
                ),
                child: Text(
                  data.status.toUpperCase(),
                  style: AppTextStyles.pillsText.copyWith(
                    color: AppColors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
