import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ultra/bonds/data/models/financials.dart';
import 'package:ultra/bonds/presentation/widgets/bar_chart.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/app_text_styles.dart';
import 'package:ultra/utils/constants.dart';
import 'package:ultra/utils/num_extensions.dart';

class CompanyFinancialsWidget extends StatefulWidget {
  final Financials data;
  const CompanyFinancialsWidget({required this.data, super.key});

  @override
  State<CompanyFinancialsWidget> createState() =>
      _CompanyFinancialsWidgetState();
}

class _CompanyFinancialsWidgetState extends State<CompanyFinancialsWidget>
    with SingleTickerProviderStateMixin {
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
      HapticFeedback.mediumImpact();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabBorderRadious = BorderRadius.only(
      topLeft: _tabController.index == 0 ? Radius.circular(20) : Radius.zero,
      bottomLeft: _tabController.index == 0 ? Radius.circular(20) : Radius.zero,
      topRight: _tabController.index == 0 ? Radius.zero : Radius.circular(20),
      bottomRight:
          _tabController.index == 0 ? Radius.zero : Radius.circular(20),
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey, width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "company financials".toUpperCase(),
                style: AppTextStyles.pillsText.copyWith(
                  color: AppColors.titleGrey,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.pillGrey,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.pillGreyBorder,
                    width: 0.4,
                  ),
                  boxShadow: appBoxShadows,
                ),
                child: TabBar(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  dividerHeight: 0,
                  unselectedLabelColor: AppColors.textGrey,
                  labelColor: AppColors.textBlack,
                  labelPadding: EdgeInsets.fromLTRB(0, 6, 0, 3),
                  tabAlignment: TabAlignment.center,
                  controller: _tabController,
                  indicator: ShapeDecoration.fromBoxDecoration(
                    BoxDecoration(
                      color: AppColors.white,
                      borderRadius: tabBorderRadious,
                      border: Border.all(
                        color: AppColors.pillGreyBorder,
                        width: 0.4,
                      ),
                    ),
                  ),
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("EBITDA", style: AppTextStyles.medium1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Revenue", style: AppTextStyles.medium1),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.sh,
          IndexedStack(
            index: _tabController.index,
            children: [
              BarChart(companyFinancials: widget.data),
              BarChart(companyFinancials: widget.data, isRevenue: true),
            ],
          ),
        ],
      ),
    );
  }
}
