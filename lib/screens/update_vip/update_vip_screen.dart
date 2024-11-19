import 'package:do_an_tot_nghiep/features/user/bloc/user_duration_option_get_bloc.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_duration_option_get_event.dart';
import 'package:do_an_tot_nghiep/features/user/bloc/user_duration_option_get_state.dart';
import 'package:do_an_tot_nghiep/features/user/data/user_repository.dart';
import 'package:do_an_tot_nghiep/features/user/dtos/user_duration_option_success_dto.dart';
import 'package:do_an_tot_nghiep/utils/formatters/formatter.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../common/widgets/layout/grid_layout.dart';
import '../../common/widgets/products/product_card.dart';
import '../../configs/router.dart';
import '../../features/user/data/user_api_client.dart';
import '../../injection_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

class UpdateVipScreen extends StatelessWidget {
  const UpdateVipScreen({super.key, this.durationId});

  final int? durationId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserDurationOptionGetBloc(UserRepository(sl<UserApiClient>()))
            ..add(UserDurationOptionGetStarted()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.primary.withOpacity(0.15),
          leadingWidth: 80,
          actions: [
            const ArrowBack(),
            const Spacer(),
            Text(
              AppText.vipUser,
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
                Text(
                  AppText.optionVip,
                  style: context.text.headlineSmall!.copyWith(
                    fontSize: AppSizes.fontSizeLg,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                UpdateVipContent(
                  durationId: durationId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateVipContent extends StatelessWidget {
  const UpdateVipContent({
    super.key,
    required this.durationId,
  });
  final int? durationId;

  @override
  Widget build(BuildContext context) {
    void handleGoUpdateVipDetail(int durationId, String durationName,
        int durationTime, int durationPrice) {
      context.push(
        '${RouteName.user}/${RouteName.updateVip}/${RouteName.updateVipDetail.replaceFirst(':id', durationId.toString())}',
        extra: UserDurationOptionSuccessDto(
          durationId: durationId,
          durationName: durationName,
          durationTime: durationTime,
          durationPrice: durationPrice,
        ),
      );
    }

    return BlocBuilder<UserDurationOptionGetBloc, UserDurationOptionGetState>(
      builder: (context, state) {
        if (state is UserDurationOptionGetSuccess) {
          return AppGridLayout(
              itemCount: state.userDurationOptionSuccessDto.length,
              itemBuilder: (_, index) {
                final data = state.userDurationOptionSuccessDto[index];
                if (durationId == null && data.durationId != 6) {
                  return ProductCardWidget(
                    title:
                        'Vip ${data.durationId} - ${data.durationTime} ${AppFormatter.formatTime(data.durationName)}',
                    subText: AppFormatter.formatVNDCurrency(data.durationPrice),
                    image:
                        'https://cdn.pixabay.com/photo/2015/11/06/13/25/vip-1027858_1280.jpg',
                    onTap: () => handleGoUpdateVipDetail(
                      data.durationId,
                      data.durationName,
                      data.durationTime,
                      data.durationPrice,
                    ),
                  );
                }
                if (durationId != null && data.durationId != 6) {
                  return Hero(
                    tag: data.durationId,
                    child: ProductCardWidget(
                      backgroundColor:
                          data.durationId == durationId ? AppColors.grey : null,
                      header:
                          data.durationId == durationId ? 'Hiện tại:' : null,
                      title:
                          'Vip ${data.durationId} - ${data.durationTime} ${AppFormatter.formatTime(data.durationName)}',
                      subText:
                          AppFormatter.formatVNDCurrency(data.durationPrice),
                      image: data.durationId == durationId
                          ? 'https://media.istockphoto.com/id/1408670475/vi/vec-to/%C4%91%C3%A1nh-gi%C3%A1-c%E1%BB%A7a-kh%C3%A1ch-h%C3%A0ng-v%E1%BB%9Bi-bi%E1%BB%83u-t%C6%B0%E1%BB%A3ng-sao-v%C3%A0ng-tr%C3%AAn-m%C3%A0n-h%C3%ACnh-m%C3%A1y-t%C3%ADnh-x%C3%A1ch-tay-m%E1%BB%8Di-ng%C6%B0%E1%BB%9Di.jpg?s=612x612&w=0&k=20&c=SRQy1LGkS05xqQta7T9hGWwq4D9QA27-fhxbdB60ZkU='
                          : 'https://cdn.pixabay.com/photo/2015/11/06/13/25/vip-1027858_1280.jpg',
                      onTap: () {},
                    ),
                  );
                }
                return const SizedBox.shrink();
              });
        }
        if (state is UserDurationOptionGetFailure) {
          return Text(state.msg);
        } else {
          return Container();
        }
      },
    );
  }
}
