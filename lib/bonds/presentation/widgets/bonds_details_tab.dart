import 'package:flutter/material.dart';
import 'package:ultra/bonds/data/models/company_details_model.dart';
import 'package:ultra/bonds/presentation/widgets/ananlysis_widget.dart';
import 'package:ultra/bonds/presentation/widgets/pros_n_cons_widget.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/app_text_styles.dart';
import 'package:ultra/utils/constants.dart';

class BondsDetailsTab extends StatefulWidget {
  final CompanyDetailsModel data;
  const BondsDetailsTab({super.key, required this.data});

  @override
  State<BondsDetailsTab> createState() => _BondsDetailsTabState();
}

class _BondsDetailsTabState extends State<BondsDetailsTab>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TabBar(
        isScrollable: true,
        padding: EdgeInsets.symmetric(horizontal: 20),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        unselectedLabelColor: AppColors.textTabUnselected,
        labelColor: AppColors.blue,
        indicatorColor: AppColors.blue,
        dividerHeight: 0.5,
        labelPadding: EdgeInsets.fromLTRB(0, 12, 24, 12),
        dividerColor: AppColors.grey,
        tabAlignment: TabAlignment.start,
        controller: _tabController,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: AppColors.blue),
        ),
        tabs: [
          Text(analysisTabText, style: AppTextStyles.titleSmall),
          Text(prosNConsTabText, style: AppTextStyles.titleSmall),
        ],
      ),
      IndexedStack(
        index: _tabController.index,
        children: [
          AnanlysisWidget(data: widget.data),
          ProsNConsWidget(prosAndCons: widget.data.prosAndCons),
        ],
      ),
    ],
  );
}
