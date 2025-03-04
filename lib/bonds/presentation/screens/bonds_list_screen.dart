import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultra/bonds/cubit/bonds_list_cubit.dart';
import 'package:ultra/bonds/cubit/bonds_list_state.dart';
import 'package:ultra/bonds/data/models/bond_item_model.dart';
import 'package:ultra/bonds/data/repositories/bonds_repository.dart';
import 'package:ultra/di/injectable.dart';
import 'package:ultra/bonds/presentation/transitions/size_fase_transition.dart';
import 'package:ultra/bonds/presentation/widgets/auto_animates_list.dart';
import 'package:ultra/gen/assets.gen.dart';
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
        child: BlocProvider(
          create:
              (context) =>
                  BondsListCubit(getIt<BondsRepository>())..loadMarketItems(),
          child: const BondsListContent(),
        ),
      ),
    );
  }
}

class BondsListContent extends StatelessWidget {
  const BondsListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BondsListCubit, BondsListState>(
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
                  Flexible(child: BondsList(state.filteredItems)),
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
    );
  }
}

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
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
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

class BondItemContent extends StatelessWidget {
  final BondItem item;
  const BondItemContent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final titleSmall =
        item.isin.substring(0, item.isin.length - 4).toUpperCase();
    final titleBig = item.isin.substring(item.isin.length - 4).toUpperCase();
    return GestureDetector(
      onTapUp: (details) {
        HapticFeedback.heavyImpact();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: item.logo,
              imageBuilder:
                  (context, imageProvider) => Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.grey, width: 0.5),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            10.sw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: titleSmall,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                        TextSpan(
                          text: titleBig,
                          style: AppTextStyles.titleBig.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  2.sh,
                  Text(
                    '${item.rating} • ${item.name}',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Assets.icons.icRight.svg(),
          ],
        ),
      ),
    );
  }
}
