import 'package:do_an_tot_nghiep/common/widgets/products/product_card.dart';
import 'package:do_an_tot_nghiep/features/history/bloc/history_user_bloc.dart';
import 'package:do_an_tot_nghiep/features/history/bloc/history_user_event.dart';
import 'package:do_an_tot_nghiep/features/history/bloc/history_user_state.dart';
import 'package:do_an_tot_nghiep/features/history/data/history_api_client.dart';
import 'package:do_an_tot_nghiep/features/history/data/history_repository.dart';
import 'package:do_an_tot_nghiep/utils/constants/api_constants.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/constants/text_strings.dart';
import 'package:do_an_tot_nghiep/utils/formatters/formatter.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../common/widgets/layout/grid_layout.dart';
import '../../injection_container.dart';
import '../../utils/constants/colors.dart';

class HistoryReviewScreen extends StatelessWidget {
  const HistoryReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: AppColors.primary.withOpacity(0.15),
        leadingWidth: 80,
        actions: [
          const ArrowBack(),
          const Spacer(),
          Text(
            AppText.historyReview,
            style: context.text.headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            HistoryUserGetBloc(HistoryRepository(sl<HistoryApiClient>()))
              ..add(HistoryUserGetStarted()),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppText.hisory,
                  style: context.text.headlineSmall!.copyWith(
                    fontSize: AppSizes.fontSizeLg,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                const HistoryContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryContent extends StatelessWidget {
  const HistoryContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryUserGetBloc, HistoryUserGetState>(
      builder: (context, state) {
        if (state is HistoryUserGetSuccess) {
          return AppGridLayout(
            itemCount: state.historyUserSuccessDto.length,
            mainAxisExtent: 180,
            itemBuilder: (_, index) {
              final data = state.historyUserSuccessDto[index];
              return ProductCardWidget(
                title: data.ratingName,
                header:
                    'Ngày: ${AppFormatter.getFormattedDateDayMonthYearVN(data.createdAt)}',
                subText: 'Độ tươi: ${data.ratingValue}',
                image:
                    '${AppApi.apiSecondNoApi}/media/images-no-bg/${AppFormatter.extractFilenameFromUrl(data.imageUrl)}',
                onTap: () {},
              );
            },
          );
        }
        if (state is HistoryUserGetInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HistoryUserGetFailure) {
          return Text(state.msg);
        }
        return Container();
      },
    );
  }
}
