import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultra/bonds/cubit/bonds_list_cubit.dart';
import 'package:ultra/gen/assets.gen.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/app_text_styles.dart';
import 'package:ultra/utils/num_extensions.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey, width: 0.5),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          12.sw,
          Assets.icons.icGlass.svg(width: 14, height: 14),
          12.sw,
          Expanded(
            child: TextField(
              cursorHeight: 20,
              controller: _searchController,
              style: AppTextStyles.textField.copyWith(color: AppColors.black),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10),
                hintText: 'Search by Issuer Name or ISIN',
                hintStyle: AppTextStyles.textField.copyWith(
                  color: AppColors.textGrey,
                ),
                border: InputBorder.none,
                hintMaxLines: 1,
              ),
              maxLines: 1,
              onChanged: (query) {
                context.read<BondsListCubit>().searchBonds(query);
              },
            ),
          ),
          12.sw,
        ],
      ),
    );
  }
}
