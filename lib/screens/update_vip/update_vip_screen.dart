import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../common/widgets/layout/grid_layout.dart';
import '../../common/widgets/products/product_card.dart';
import '../../configs/router.dart';
import '../../mock_data/products.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

class UpdateVipScreen extends StatelessWidget {
  const UpdateVipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void handleGoUpdateVipDetail(String durationId) {
      context.push(
          '${RouteName.user}/${RouteName.updateVip}/${RouteName.updateVipDetail.replaceFirst(':id', durationId)}');
    }

    return Scaffold(
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
              AppGridLayout(
                itemCount: productFake.length,
                itemBuilder: (_, index) {
                  return ProductCardWidget(
                    backgroundColor: index == 0 ? AppColors.grey : null,
                    header: index == 0 ? 'Hiện tại:' : null,
                    title: 'Vip $index - 30 ngày',
                    image: index == 0
                        ? 'https://media.istockphoto.com/id/1408670475/vi/vec-to/%C4%91%C3%A1nh-gi%C3%A1-c%E1%BB%A7a-kh%C3%A1ch-h%C3%A0ng-v%E1%BB%9Bi-bi%E1%BB%83u-t%C6%B0%E1%BB%A3ng-sao-v%C3%A0ng-tr%C3%AAn-m%C3%A0n-h%C3%ACnh-m%C3%A1y-t%C3%ADnh-x%C3%A1ch-tay-m%E1%BB%8Di-ng%C6%B0%E1%BB%9Di.jpg?s=612x612&w=0&k=20&c=SRQy1LGkS05xqQta7T9hGWwq4D9QA27-fhxbdB60ZkU='
                        : 'https://cdn.pixabay.com/photo/2015/11/06/13/25/vip-1027858_1280.jpg',
                    onTap: () => handleGoUpdateVipDetail(index.toString()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
