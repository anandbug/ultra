import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ultra/bonds/presentation/cubit/bond_details_cubit.dart';
import 'package:ultra/bonds/presentation/cubit/bond_details_state.dart';
import 'package:ultra/bonds/data/models/company_details_model.dart';
import 'package:ultra/bonds/presentation/widgets/back_botton_widget.dart';
import 'package:ultra/bonds/presentation/widgets/bonds_details_tab.dart';
import 'package:ultra/bonds/presentation/widgets/company_details_widget.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/num_extensions.dart';

class BondsDetailsScreen extends StatelessWidget {
  const BondsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButtonWidget(
              onTap: () {
                HapticFeedback.heavyImpact();
                context.pop();
              },
            ),
            12.sh,
            Flexible(
              child: BlocBuilder<BondDetailsCubit, BondsDetailsState>(
                builder: (context, state) {
                  switch (state) {
                    case CompanyDetailsLoading():
                      return const Center(child: CircularProgressIndicator())
                          .animate()
                          .moveY(
                            begin: 4,
                            duration: 300.ms,
                            curve: Curves.easeIn,
                          )
                          .fade(
                            begin: 0,
                            delay: 100.ms,
                            duration: 300.ms,
                            curve: Curves.easeIn,
                          );
                    case CompanyDetailsLoaded():
                      return BondDetailsPage(data: state.companyDetailsModel);
                    case CompanyDetailsError():
                      return Center(child: Text(state.message));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BondDetailsPage extends StatelessWidget {
  final CompanyDetailsModel data;
  const BondDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        CompanyDetailsWidget(data: data)
            .animate()
            .moveY(
              begin: 4,
              delay: 100.ms,
              duration: 300.ms,
              curve: Curves.easeIn,
            )
            .fade(
              begin: 0,
              delay: 200.ms,
              duration: 300.ms,
              curve: Curves.easeIn,
            ),
        12.sh,
        BondsDetailsTab(data: data)
            .animate()
            .moveY(
              begin: 4,
              delay: 200.ms,
              duration: 300.ms,
              curve: Curves.easeIn,
            )
            .fade(
              begin: 0,
              delay: 300.ms,
              duration: 300.ms,
              curve: Curves.easeIn,
            ),
      ],
    );
  }
}
