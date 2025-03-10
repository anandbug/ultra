import 'package:flutter/material.dart';
import 'package:ultra/bonds/data/models/bond_item_model.dart';
import 'package:ultra/bonds/presentation/transitions/size_fase_transition.dart';
import 'package:ultra/bonds/presentation/widgets/auto_animates_list.dart';
import 'package:ultra/bonds/presentation/widgets/bond_item_content.dart';
import 'package:ultra/utils/app_colors.dart';

class BondsList extends StatelessWidget {
  final List<BondItem> items;

  const BondsList(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey, width: 0.5),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: AutoAnimatedList<BondItem>(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder:
            (context, bond, index, animation) => SizeFadeTransition(
              animation: animation,
              child: BondItemContent(item: items[index]),
            ),
        items: items,
      ),
    );
  }
}
