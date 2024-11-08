import 'package:do_an_tot_nghiep/features/version/bloc/option_rating_get_bloc.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/option_rating_get_event.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/option_rating_get_state.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/total_rating_avg_rating_get_bloc.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/total_rating_avg_rating_get_event.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/total_rating_avg_rating_get_state.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/user_rating_get_bloc.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/user_rating_get_event.dart';
import 'package:do_an_tot_nghiep/features/version/bloc/user_rating_get_state.dart';
import 'package:do_an_tot_nghiep/features/version/dtos/option_rating_get_success_dto.dart';
import 'package:do_an_tot_nghiep/features/version/dtos/total_rating_avg_rating_get_success_dto.dart';
import 'package:do_an_tot_nghiep/utils/formatters/formatter.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';

import '../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../components/widgets/dialog/snack_bar.dart';
import '../../injection_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

class VersionScreen extends StatelessWidget {
  const VersionScreen({super.key, required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                OptionRatingGetBloc(sl())..add(OptionRatingGetStarted())),
        BlocProvider(
            create: (context) => TotalRatingAvgRatingGetBloc(sl())
              ..add(TotalRatingAvgRatingGetStarted())),
        BlocProvider(
            create: (context) =>
                UserRatingGetBloc(sl())..add(UserRatingGetStarted())),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.primary.withOpacity(0.15),
          leadingWidth: 80,
          actions: [
            const ArrowBack(),
            const Spacer(),
            Text(
              AppText.versions,
              style: context.text.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InforVersion(),
                const SizedBox(height: AppSizes.spaceBtwSections),
                const OptionRating(),
                const SizedBox(height: AppSizes.spaceBtwSections / 2),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<TotalRatingAvgRatingGetBloc,
                      TotalRatingAvgRatingGetState>(
                    builder: (context, totalRatingState) {
                      final state = context.watch<UserRatingGetBloc>().state;

                      if (totalRatingState is TotalRatingAvgRatingGetSuccess) {
                        final versionId = totalRatingState
                            .data.versionId; // lấy versionId từ state
                        if (state is UserRatingGetSuccess) {
                          if (state.reviewOptions.isNotEmpty &&
                              state.rating > 0) {
                            return ElevatedButton.icon(
                              onPressed: () {
                                context.read<UserRatingGetBloc>().add(
                                      UserRatingAddStarted(
                                        userId: userId,
                                        versionId: versionId,
                                      ),
                                    );
                              },
                              label: const Text(AppText.submitSendRating),
                            );
                          }
                        }
                      }
                      return ElevatedButton.icon(
                        onPressed:
                            null, // nếu state không thành công, disable button
                        label: const Text(AppText.submitSendRating),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Danh sách đánh giá',
                      style: context.text.headlineSmall!
                          .copyWith(color: AppColors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems / 2),
                    const ListUserRating(),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListUserRating extends StatelessWidget {
  const ListUserRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserRatingGetBloc, UserRatingGetState>(
      listener: (context, state) {
        if (state is UserRatingGetSuccess) {
          if (state.isRating) {
            AppShowSnackBar.show(
                context: context, message: AppText.ratingComent);
          }
        }
      },
      child: BlocBuilder<UserRatingGetBloc, UserRatingGetState>(
          builder: (context, state) {
        if (state is UserRatingGetSuccess) {
          return ListView.builder(
              itemCount: state.data.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = state.data[index];
                return UserRatingItem(
                  email: data.email,
                  versionName: data.nameVersion,
                  star: data.rating.toDouble(),
                  createdAt: data.createdAt,
                  option: data.reviewOptions,
                );
              });
        }
        if (state is UserRatingGetInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserRatingGetFailure) {
          return Center(child: Text(state.msg));
        }
        return Container();
      }),
    );
  }
}

class UserRatingItem extends StatelessWidget {
  const UserRatingItem({
    super.key,
    required this.email,
    required this.versionName,
    required this.star,
    required this.createdAt,
    required this.option,
  });

  final String email, versionName;
  final double star;
  final DateTime createdAt;
  final String option;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm)),
          padding: const EdgeInsets.all(AppSizes.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email: $email',
                style: context.text.bodyLarge!.copyWith(color: AppColors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              StarRating(
                mainAxisAlignment: MainAxisAlignment.start,
                size: 20,
                color: AppColors.star,
                rating: star,
                allowHalfRating: false,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              Text(
                'Tên phiên bản: $versionName',
                style:
                    context.text.bodyLarge!.copyWith(color: AppColors.subText),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              Text(
                'Ngày tạo: ${AppFormatter.getFormattedDateDayMonthYear(createdAt)}',
                style:
                    context.text.bodyLarge!.copyWith(color: AppColors.subText),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              Text(
                option,
                style:
                    context.text.bodyLarge!.copyWith(color: AppColors.subText),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
      ],
    );
  }
}

class InforVersion extends StatelessWidget {
  const InforVersion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int rating = 0;
    final state = context.watch<UserRatingGetBloc>().state;
    if (state is UserRatingGetSuccess) {
      rating = state.rating;
    }
    Widget buildInitialInforVersion(
        BuildContext context, TotalRatingAvgRatingGetSuccessDto data) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppText.versions}: ${data.nameVersion}',
            style: context.text.headlineSmall!.copyWith(
              fontSize: AppSizes.fontSizeMd,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),
          Text(
            'Ngày tạo: ${AppFormatter.getFormattedDateDayMonthYear(data.createdAt)}',
            style: context.text.headlineSmall!.copyWith(
              fontSize: AppSizes.fontSizeMd,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          Container(
            color: AppColors.grey,
            padding: const EdgeInsets.all(AppSizes.sm),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          AppFormatter.roundToSingleDecimal(
                                  double.parse(data.avgRating))
                              .toString(),
                          style: context.text.headlineSmall!.copyWith(
                            fontSize: AppSizes.fontSizeLg,
                            color: AppColors.subText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwItems / 2),
                        StarRating(
                          size: 25,
                          color: AppColors.star,
                          allowHalfRating: true,
                          rating: double.parse(
                              double.parse(data.avgRating).toStringAsFixed(1)),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwItems / 2),
                        Text(
                          data.totalRating,
                          style: context.text.headlineSmall!.copyWith(
                            fontSize: AppSizes.fontSizeLg,
                            color: AppColors.subText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Đánh giá model',
                            style: context.text.headlineSmall!.copyWith(
                              fontSize: AppSizes.fontSizeMd,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems / 2),
                          StarRating(
                            size: 30,
                            color: AppColors.star,
                            rating: rating.toDouble(),
                            allowHalfRating: false,
                            onRatingChanged: (rating) {
                              context.read<UserRatingGetBloc>().add(
                                    UserRatingPostStarted(
                                        rating: rating.toInt()),
                                  );
                            },
                          ),
                          const SizedBox(height: AppSizes.spaceBtwInputFields),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    return BlocBuilder<TotalRatingAvgRatingGetBloc,
        TotalRatingAvgRatingGetState>(builder: (context, state) {
      if (state is TotalRatingAvgRatingGetSuccess) {
        return buildInitialInforVersion(context, state.data);
      }
      if (state is TotalRatingAvgRatingGetInProgress) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is TotalRatingAvgRatingGetFailure) {
        return Center(child: Text(state.msg));
      } else {
        return Container();
      }
    });
  }
}

class OptionRating extends StatelessWidget {
  const OptionRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionRatingGetBloc, OptionRatingGetState>(
      builder: (context, state) {
        if (state is OptionRatingGetSuccess) {
          return buildInitialOptionRatingWidget(state.data);
        }
        if (state is OptionRatingGetInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OptionRatingGetFailure) {
          return Center(child: Text(state.msg));
        }
        return Container();
      },
    );
  }

  Widget buildInitialOptionRatingWidget(List<OptionRatingGetSuccessDto> datas) {
    return Column(
      children: [
        ListView.builder(
            itemCount: datas.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final data = datas[index];
              bool isChecked = false;
              final state = context.watch<UserRatingGetBloc>().state;
              if (state is UserRatingGetSuccess) {
                isChecked = state.reviewOptions.any(
                    (option) => data.reviewOptionId == option.reviewOptionId);
              }
              return Padding(
                padding: const EdgeInsets.all(AppSizes.xs),
                child: CheckboxListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  tileColor: AppColors.primary.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  title: Text(data.reviewOptionName),
                  value: isChecked,
                  onChanged: (bool? value) {
                    context.read<UserRatingGetBloc>().add(
                          UserRatingPostStarted(
                              reviewOptionid: data.reviewOptionId),
                        );
                  },
                ),
              );
            }),
      ],
    );
  }
}
