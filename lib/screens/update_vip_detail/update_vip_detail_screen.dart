import 'package:do_an_tot_nghiep/configs/router.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/custom_shapes/containers/arrow_back.dart';
import '../../common/widgets/images/rounded_image.dart';
import '../../utils/constants/colors.dart';
import '../../utils/formatters/formatter.dart';

class UpdateVipDetailScreen extends StatelessWidget {
  const UpdateVipDetailScreen({
    super.key,
    required this.durationId,
    required this.durationTime,
    required this.durationName,
    required this.durationPrice,
  });

  final int durationId;
  final int durationTime;
  final String durationName;
  final int durationPrice;

  @override
  Widget build(BuildContext context) {
    void handleGoPayment(int durationId) {
      context.push(
        '${RouteName.user}/${RouteName.updateVip}/${RouteName.payment}',
        extra: durationId,
      );
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
              'Chi tiết tài koản vip $durationId',
              style: context.text.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: durationId,
                  child: const AppRoundedImage(
                    padding: EdgeInsets.all(20),
                    isNetworkImage: true,
                    imageUrl:
                        'https://cdn.pixabay.com/photo/2015/11/06/13/25/vip-1027858_1280.jpg',
                    applyImageRadius: true,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khi nâng cấp lên VIP 4, bạn sẽ nhận được:',
                      style: context.text.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- Dịch vụ đánh giá chi tiết từng sản phẩm.',
                      style: context.text.bodyLarge,
                    ),
                    Text(
                      '- Hiển thị đầy đủ thông tin về độ tươi.',
                      style: context.text.bodyLarge,
                    ),
                    Text(
                      '- Độ chính xác cao nhất trong kết quả phân tích.',
                      style: context.text.bodyLarge,
                    ),
                    RichText(
                      text: TextSpan(
                        style: context.text.bodyLarge, // Áp dụng style chung
                        children: [
                          const TextSpan(
                              text: '- Thời gian sử dụng VIP lên tới '),
                          TextSpan(
                            text: '$durationTime ',
                            style: context.text.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${AppFormatter.formatTime(durationName)}.',
                            style: context.text.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Tổng tiền: ${AppFormatter.formatVNDCurrency(durationPrice)}',
                  style: context.text.headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => handleGoPayment(durationId),
                      child: const Text('Tiến hành thanh toán')),
                ),
              ],
            ),
          ),
        ));
  }
}
