import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultra/bonds/presentation/cubit/bonds_list_cubit.dart';
import 'package:ultra/bonds/presentation/cubit/bonds_list_state.dart';
import 'package:ultra/bonds/presentation/widgets/bonds_list.dart';
import 'package:ultra/bonds/presentation/widgets/search_box.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/app_text_styles.dart';
import 'package:ultra/utils/num_extensions.dart';

class BondsListScreen extends StatelessWidget {
  const BondsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: BlocBuilder<BondsListCubit, BondsListState>(
          builder: (context, state) {
            switch (state) {
              case Loading():
                return const Center(child: CircularProgressIndicator());
              case Loaded():
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Home",
                          style: AppTextStyles.header.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                    SearchBox(),
                    24.sh,
                    if (state.filteredItems.isNotEmpty) ...[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "suggested results".toUpperCase(),
                          style: AppTextStyles.sectionHeader.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                      ),
                      8.sh,
                      Flexible(
                        child: BondsList(
                          state.filteredItems,
                          state.searchQueryList,
                        ),
                      ),
                    ],
                    if (state.filteredItems.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text(
                            "No results found",
                            style: AppTextStyles.header.copyWith(
                              color: AppColors.textGrey,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              case Error():
                return Center(child: Text(state.message));
            }
          },
        ),
      ),
    );
  }
}
