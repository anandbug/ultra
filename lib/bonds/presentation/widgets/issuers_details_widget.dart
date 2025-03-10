import 'package:flutter/material.dart';
import 'package:ultra/bonds/data/models/issuer_details.dart';
import 'package:ultra/gen/assets.gen.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/app_text_styles.dart';
import 'package:ultra/utils/constants.dart';
import 'package:ultra/utils/num_extensions.dart';

class IssuerDetailsWidget extends StatelessWidget {
  final IssuerDetails data;
  const IssuerDetailsWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey, width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              24.sw,
              Assets.icons.icAddress.svg(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 16, 24, 16),
                  child: Text(issuerDetailsTitle, style: AppTextStyles.medium3),
                ),
              ),
            ],
          ),
          Divider(color: AppColors.grey, height: 1),
          30.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Issuer Name",
              style: AppTextStyles.medium2.copyWith(color: AppColors.blue),
            ),
          ),
          6.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.issuerName,
              style: AppTextStyles.medium3.copyWith(
                color: AppColors.textDetailsBlack,
              ),
            ),
          ),
          30.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Type of Issuer",
              style: AppTextStyles.medium2.copyWith(color: AppColors.blue),
            ),
          ),
          6.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.typeOfIssuer,
              style: AppTextStyles.medium3.copyWith(
                color: AppColors.textDetailsBlack,
              ),
            ),
          ),
          30.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Sector",
              style: AppTextStyles.medium2.copyWith(color: AppColors.blue),
            ),
          ),
          6.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.sector,
              style: AppTextStyles.medium3.copyWith(
                color: AppColors.textDetailsBlack,
              ),
            ),
          ),
          30.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Industry",
              style: AppTextStyles.medium2.copyWith(color: AppColors.blue),
            ),
          ),
          6.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.industry,
              style: AppTextStyles.medium3.copyWith(
                color: AppColors.textDetailsBlack,
              ),
            ),
          ),
          30.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Issuer Nature",
              style: AppTextStyles.medium2.copyWith(color: AppColors.blue),
            ),
          ),
          6.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.issuerNature,
              style: AppTextStyles.medium3.copyWith(
                color: AppColors.textDetailsBlack,
              ),
            ),
          ),
          30.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Corporate Identity Number (CIN)",
              style: AppTextStyles.medium2.copyWith(color: AppColors.blue),
            ),
          ),
          6.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.cin,
              style: AppTextStyles.medium3.copyWith(
                color: AppColors.textDetailsBlack,
              ),
            ),
          ),
          30.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Name of the Lead Manager",
              style: AppTextStyles.medium2.copyWith(color: AppColors.blue),
            ),
          ),
          6.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.leadManager,
              style: AppTextStyles.medium3.copyWith(
                color: AppColors.textDetailsBlack,
              ),
            ),
          ),
          30.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Registrar",
              style: AppTextStyles.medium2.copyWith(color: AppColors.blue),
            ),
          ),
          6.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.registrar,
              style: AppTextStyles.medium3.copyWith(
                color: AppColors.textDetailsBlack,
              ),
            ),
          ),
          30.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Name of Debenture Trustee",
              style: AppTextStyles.medium2.copyWith(color: AppColors.blue),
            ),
          ),
          6.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.debentureTrustee,
              style: AppTextStyles.medium3.copyWith(
                color: AppColors.textDetailsBlack,
              ),
            ),
          ),
          30.sh,
        ],
      ),
    );
  }
}
