import 'package:do_an_tot_nghiep/components/widgets/card/icon_card.dart';
import 'package:do_an_tot_nghiep/configs/router.dart';
import 'package:do_an_tot_nghiep/screens/home/widgets/avatar_widget.dart';
import 'package:do_an_tot_nghiep/screens/home/widgets/button_notification_widget.dart';
import 'package:do_an_tot_nghiep/screens/home/widgets/introduction_text_widget.dart';
import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:do_an_tot_nghiep/utils/constants/image_strings.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/constants/text_strings.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../components/widgets/card/image_file_card.dart';
import '../../features/home/bloc/image_predict_bloc.dart';
import '../../features/home/bloc/image_predict_event.dart';
import '../../features/home/bloc/image_predict_state.dart';
import '../../mock_data/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.fullName});
  final String? fullName;

  @override
  Widget build(BuildContext context) {
    final data = userFake;

    return BlocProvider(
      create: (context) => ImagePredictBloc()..add(LoadModelEvent()),
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //   Avatar && Notification Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Avatar
                      fullName == null
                          ? GestureDetector(
                              onTap: () {
                                context.push(RouteName.login);
                              },
                              child:
                                  const AvatarWidget(userName: AppText.signIn))
                          : GestureDetector(
                              onTap: () {
                                context.push(RouteName.user);
                              },
                              child: AvatarWidget(
                                userName: fullName ?? '',
                                image: data.avatar,
                              ),
                            ),
                      // Button Notification
                      ButtonNotification(
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  // Introduction text
                  const IntroductionText(),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  Text('Chọn ảnh để tiến hành đánh giá',
                      style: context.text.titleLarge),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  const ReviewFruits(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewFruits extends StatelessWidget {
  const ReviewFruits({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imagePredictBloc = context.watch<ImagePredictBloc>().state;

    var imagePredictWidget = switch (imagePredictBloc) {
      ImagePredictLoading() => const ImageFileCardWidget(
          title: AppText.loading,
          isAssetImage: true,
          file: AppImages.loading,
        ),
      ImagePredictSuccess() => ImageFileCardWidget(
          title: imagePredictBloc.result,
          file: imagePredictBloc.imageRemove,
          isMemoryImage: true,
        ),
      ImagePredictFailure() => const ImageFileCardWidget(
          title: AppText.error,
          isAssetImage: true,
          file: AppImages.error,
        ),
      _ => Container()
    };

    void handleImagePredict(bool isCamera) {
      context
          .read<ImagePredictBloc>()
          .add(PickImageFromGalleryEvent(isCamera: isCamera));
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconCardWidget(
              title: AppText.gallery,
              image: AppImages.gallery,
              onTap: () => handleImagePredict(false),
            ),
            IconCardWidget(
              title: AppText.camera,
              image: AppImages.camera,
              onTap: () => handleImagePredict(true),
            )
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Center(child: imagePredictWidget)
      ],
    );
  }
}
