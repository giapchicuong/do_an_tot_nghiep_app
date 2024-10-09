import 'package:do_an_tot_nghiep/configs/router.dart';
import 'package:do_an_tot_nghiep/mock_data/user.dart';
import 'package:do_an_tot_nghiep/screens/user/widgets/card_item.dart';
import 'package:do_an_tot_nghiep/screens/user/widgets/list_title_user.dart';
import 'package:do_an_tot_nghiep/utils/constants/sizes.dart';
import 'package:do_an_tot_nghiep/utils/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/text_strings.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  void _handleGoHistoryReview() {
    context.push('${RouteName.user}/${RouteName.history}');
  }

  // void _handleGoAnalyst() {
  //   context.push('${RouteName.user}/${RouteName.analyst}');
  // }
  //
  // void _handleGoSettings() {
  //   context.push('${RouteName.user}/${RouteName.settings}');
  // }

  void _handleLogout() {
    context.pushReplacement(RouteName.login);
  }

  @override
  Widget build(BuildContext context) {
    final data = userFake;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.15),
        leadingWidth: 80,
        actions: [
          const Spacer(),
          Text(
            AppText.profile,
            style: context.text.headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(data.avatar),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: AppSizes.md),
                  Text(
                    data.fullName,
                    style: context.text.headlineMedium,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    data.email,
                    style: context.text.bodyMedium,
                  )
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Row(
                children: [
                  CardItem(
                    title: AppText.numberReview,
                    number: '30',
                    borderLeft: true,
                  ),
                  Expanded(
                    child: CardItem(
                      title: AppText.numberProduct,
                      number: '30',
                      borderRight: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            Column(
              children: [
                ListTitleUser(
                  title: AppText.vipUser,
                  icon: Icons.account_tree_outlined,
                  onTap: () => _handleGoHistoryReview(),
                ),
                const ListTitleUser(
                  title: AppText.settings,
                  icon: Icons.settings,
                  // onTap: () => _handleGoSettings(),
                ),
                ListTitleUser(
                  title: AppText.logout,
                  icon: Icons.logout,
                  onTap: () => _handleLogout(),
                ),
                const ListTitleUser(
                  title: AppText.versions,
                  icon: Icons.account_tree_sharp,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
