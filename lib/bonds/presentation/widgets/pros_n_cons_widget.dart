import 'package:flutter/material.dart';
import 'package:ultra/bonds/data/models/pros_and_cons.dart';
import 'package:ultra/gen/assets.gen.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/app_text_styles.dart';
import 'package:ultra/utils/constants.dart';
import 'package:ultra/utils/num_extensions.dart';

class ProsNConsWidget extends StatelessWidget {
  final ProsAndCons prosAndCons;
  const ProsNConsWidget({super.key, required this.prosAndCons});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Text(
              prosNConsTitleText,
              style: AppTextStyles.titleBig.copyWith(
                color: AppColors.blackTitle,
                letterSpacing: 0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pros",
                  style: AppTextStyles.companyTitle.copyWith(
                    color: AppColors.prosGreen,
                  ),
                ),
                16.sh,
                ...prosAndCons.pros.map(
                  (e) => Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Assets.icons.icTick.svg(),
                          10.sw,
                          Flexible(
                            child: Text(
                              e,
                              style: AppTextStyles.medium2.copyWith(
                                color: AppColors.blackPros,
                              ),
                            ),
                          ),
                        ],
                      ),
                      24.sh,
                    ],
                  ),
                ),
                8.sh,
                Text(
                  "Pros",
                  style: AppTextStyles.companyTitle.copyWith(
                    color: AppColors.consRed,
                  ),
                ),
                16.sh,

                ...prosAndCons.cons.map(
                  (e) => Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Assets.icons.icTick.svg(),
                          10.sw,
                          Flexible(
                            child: Text(
                              e,
                              style: AppTextStyles.medium2.copyWith(
                                color: AppColors.consGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      24.sh,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
