// import 'package:do_an_tot_nghiep/screens/home/widgets/avatar_widget.dart';
// import 'package:do_an_tot_nghiep/screens/home/widgets/button_notification_widget.dart';
// import 'package:do_an_tot_nghiep/screens/home/widgets/introduction_text_widget.dart';
// import 'package:do_an_tot_nghiep/screens/home/widgets/product_item_widget.dart';
// import 'package:do_an_tot_nghiep/screens/home/widgets/title_of_list_products.dart';
// import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
// import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
// import 'package:do_an_tot_nghiep/utils/constants/text_strings.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../configs/router.dart';
// import '../../mock_data/products.dart';
// import '../../mock_data/user.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   void _handleGoFavoriteProducts() {
//     context.push(RouteName.productsFavorites);
//   }
//
//   void _handleGoTrendingProducts() {
//     context.push(RouteName.productsTrending);
//   }
//
//   void _handleGoProductItem(productId, product) {
//     context.push(
//       RouteName.product.replaceFirst(':id', productId),
//       extra: product,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final data = userFake;
//     return Scaffold(
//       backgroundColor: AppColors.primaryBackground,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(AppSizes.lg),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 //   Avatar && Notification Icon
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Avatar
//                     AvatarWidget(
//                       userName: data.fullName,
//                       image: data.avatar,
//                     ),
//                     // Button Notification
//                     ButtonNotification(
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: AppSizes.spaceBtwSections),
//
//                 // Introduction text
//                 const IntroductionText(),
//                 const SizedBox(height: AppSizes.spaceBtwSections),
//
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Title && See All
//                     TitleOfListProducts(
//                       title: AppText.favorite,
//                       onPressed: () => _handleGoFavoriteProducts(),
//                     ),
//                     const SizedBox(height: AppSizes.xs),
//
//                     // List view horizontal
//                     SizedBox(
//                       width: double.infinity,
//                       height: 400,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         itemCount: productFake.length,
//                         itemBuilder: (context, index) {
//                           final data = productFake[index];
//                           return ProductItemWidget(
//                             nameProduct: data.title,
//                             percent: data.percent,
//                             quantityPerson: data.numberPerson,
//                             image: data.image,
//                             onTap: () => _handleGoProductItem(data.id, data),
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: AppSizes.spaceBtwSections),
//
//                     // Title && See All
//                     TitleOfListProducts(
//                       title: AppText.trending,
//                       onPressed: () => _handleGoTrendingProducts(),
//                     ),
//                     const SizedBox(height: AppSizes.xs),
//
//                     // List view horizontal
//                     SizedBox(
//                       width: double.infinity,
//                       height: 400,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         itemCount: productFake.length,
//                         itemBuilder: (context, index) {
//                           final data = productFake[index];
//                           return ProductItemWidget(
//                             nameProduct: data.title,
//                             percent: data.percent,
//                             quantityPerson: data.numberPerson,
//                             image: data.image,
//                             onTap: () => _handleGoProductItem(data.id, data),
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: AppSizes.spaceBtwSections),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }dart';
import 'dart:io';
import 'dart:math';

import 'package:do_an_tot_nghiep/components/widgets/card/icon_card.dart';
import 'package:do_an_tot_nghiep/components/widgets/card/image_file_card.dart';
import 'package:do_an_tot_nghiep/screens/home/widgets/avatar_widget.dart';
import 'package:do_an_tot_nghiep/screens/home/widgets/button_notification_widget.dart';
import 'package:do_an_tot_nghiep/screens/home/widgets/introduction_text_widget.dart';
import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../../mock_data/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int getRandomPercentage() {
  final percentages = [25, 50, 75, 100];
  final random = Random();
  final randomIndex = random.nextInt(percentages.length);
  return percentages[randomIndex];
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedFile;
  int? randomPercentage;
  bool isLoading = false;
  List<dynamic> _output = [];

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  Future _pickImageFromGallaley() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    randomPercentage = getRandomPercentage();
    setState(() {
      _selectedFile = File(returnedImage.path);
    });
    detectImage(_selectedFile!);
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    randomPercentage = getRandomPercentage();
    setState(() {
      _selectedFile = File(returnedImage.path);
    });

    detectImage(_selectedFile!);
  }

  detectImage(File image) async {
    EasyLoading.show(status: 'Đang tiến hành đánh giá...');
    setState(() {
      _output = [];
      isLoading = false;
    });

    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print('Kết quả từ mô hình: $output');
    setState(() {
      if (output != null && output.isNotEmpty) {
        _output = output;
      } else {
        _output = [];
        print('Không có kết quả trả về từ mô hình.');
      }
      EasyLoading.dismiss();
      isLoading = true;
    });
  }

  loadModel() async {
    String? res = await Tflite.loadModel(
      model: 'assets/models/model.tflite',
      labels: 'assets/models/label.txt',
    );
    if (res == 'success') {
      print('Mô hình đã được tải thành công');
    } else {
      print('Lỗi tải mô hình: $res');
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = userFake;
    return Scaffold(
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
                    AvatarWidget(
                      userName: data.fullName,
                      image: data.avatar,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconCardWidget(
                      title: 'Từ thư viện',
                      image:
                          'https://cdn.pixabay.com/photo/2016/03/21/20/05/image-1271454_1280.png',
                      onTap: () => _pickImageFromGallaley(),
                    ),
                    IconCardWidget(
                      title: 'Từ camera',
                      image:
                          'https://cdn.pixabay.com/photo/2013/07/13/11/29/camera-158262_1280.png',
                      onTap: () => _pickImageFromCamera(),
                    )
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                _selectedFile != null
                    ? Center(
                        child: ImageFileCardWidget(
                          title: !isLoading
                              ? 'Đang đánh giá...'
                              : _output.isNotEmpty
                                  // ? 'Độ tươi: ${(_output[0]['confidence'] * 100).toStringAsFixed(0)} % - Tên trái cây:  ${_output[0]['label']}'
                                  ? ' ${_output[0]['label']} - ${(_output[0]['confidence'] * 100).toStringAsFixed(0)}% '
                                  : 'Không có kết quả',
                          file: _selectedFile!,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
