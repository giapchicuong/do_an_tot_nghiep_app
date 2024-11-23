import 'package:do_an_tot_nghiep/features/history/bloc/history_user_update_bloc.dart';
import 'package:do_an_tot_nghiep/features/history/bloc/history_user_update_event.dart';
import 'package:do_an_tot_nghiep/features/history/bloc/history_user_update_state.dart';
import 'package:do_an_tot_nghiep/features/history/data/history_api_client.dart';
import 'package:do_an_tot_nghiep/features/history/data/history_repository.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/constants/text_strings.dart';
import 'package:do_an_tot_nghiep/utils/formatters/formatter.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../common/widgets/custom_shapes/containers/rouded_container.dart';
import '../../common/widgets/layout/grid_layout.dart';
import '../../common/widgets/styles/shadow_styles.dart';
import '../../injection_container.dart';
import '../../utils/constants/colors.dart';

class HistoryUpdateAccountScreen extends StatelessWidget {
  const HistoryUpdateAccountScreen({super.key});

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
            AppText.historyVip,
            style: context.text.headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            HistoryUserUpdateGetBloc(HistoryRepository(sl<HistoryApiClient>()))
              ..add(HistoryUserUpdateGetStarted()),
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
                const HistoryUpdateAccountContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryUpdateAccountContent extends StatelessWidget {
  const HistoryUpdateAccountContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryUserUpdateGetBloc, HistoryUserUpdateGetState>(
      builder: (context, state) {
        if (state is HistoryUserUpdateGetSuccess) {
          return AppGridLayout(
            itemCount: state.historyUserUpdateSuccessDto.length,
            mainAxisExtent: 210,
            crossAxisCount: 1,
            itemBuilder: (_, index) {
              final data = state.historyUserUpdateSuccessDto[index];
              return Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  boxShadow: [AppShadowStyle.verticalProductShadow],
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                ),
                child: AppRoundedContainer(
                  padding: const EdgeInsets.all(AppSizes.sm),
                  backgroundColor: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //   Title
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thời gian nâng cấp: ${AppFormatter.getFormattedDateDayMonthYear(data.createdAt)}',
                              style: context.text.labelSmall,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Trạng thái: ${data.statusName}',
                              style: context.text.headlineSmall,
                            ),
                            const SizedBox(height: 5),
                            if (data.durationTime == 'forever')
                              Text(
                                'Gói vip: ${data.durationTime} ${AppFormatter.formatTime(data.durationName)}',
                                style: context.text.bodyLarge,
                              ),
                            if (data.durationTime == 'forever')
                              const SizedBox(height: 5),
                            if (data.timeEnd != null)
                              Text(
                                'Thời gian: ${AppFormatter.getFormattedDateDayMonthYearVN(data.timeStart)} -  ${AppFormatter.getFormattedDateDayMonthYearVN(data.timeEnd!)}',
                                style: context.text.bodyLarge,
                              ),
                            if (data.timeEnd != null) const SizedBox(height: 5),
                            Text(
                              'Phương thức: ${data.methodName}',
                              style: context.text.bodyLarge,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Tổng tiền: ${AppFormatter.formatVNDCurrency(data.amount)}',
                              style: context.text.titleMedium,
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        if (state is HistoryUserUpdateGetInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HistoryUserUpdateGetFailure) {
          return Text(state.msg);
        }
        return Container();
      },
    );
  }
}
