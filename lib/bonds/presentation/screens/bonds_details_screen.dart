import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ultra/bonds/cubit/bond_details_cubit.dart';
import 'package:ultra/bonds/cubit/bond_details_state.dart';
import 'package:ultra/bonds/data/models/company_details_model.dart';
import 'package:ultra/bonds/data/repositories/bonds_repository.dart';
import 'package:ultra/bonds/presentation/widgets/back_botton_widget.dart';
import 'package:ultra/bonds/presentation/widgets/bonds_details_tab.dart';
import 'package:ultra/bonds/presentation/widgets/company_details_widget.dart';
import 'package:ultra/di/injectable.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/num_extensions.dart';

class BondsDetailsScreen extends StatelessWidget {
  const BondsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: BlocProvider(
          create:
              (context) =>
                  BondDetailsCubit(getIt<BondsRepository>())
                    ..loadCompanyDetails(),
          child: BlocBuilder<BondDetailsCubit, BondsDetailsState>(
            builder: (context, state) {
              switch (state) {
                case CompanyDetailsLoading():
                  return const Center(child: CircularProgressIndicator());
                case CompanyDetailsLoaded():
                  return BondDetailsPage(data: state.companyDetailsModel);
                case CompanyDetailsError():
                  return Center(child: Text(state.message));
              }
            },
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BackButtonWidget(onTap: () => context.pop()),
        12.sh,
        Flexible(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              CompanyDetailsWidget(data: data),
              12.sh,
              BondsDetailsTab(data: data),
            ],
          ),
        ),
      ],
    );
  }
}
