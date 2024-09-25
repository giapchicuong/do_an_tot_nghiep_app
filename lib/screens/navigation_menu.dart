import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final List<IconData> _icons = [
    Iconsax.home_1_copy,
    Iconsax.calendar_1_copy,
    Iconsax.search_normal_1_copy,
    Iconsax.messages_1_copy,
    Iconsax.user_copy,
  ];

  @override
  Widget build(BuildContext context) {
    void onTap(index) {
      widget.navigationShell.goBranch(index,
          initialLocation: index == widget.navigationShell.currentIndex);
    }

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.white,
        index: widget.navigationShell.currentIndex,
        onTap: onTap,
        items: List.generate(_icons.length, (index) {
          return Icon(
            _icons[index],
            color: widget.navigationShell.currentIndex == index
                ? AppColors.primary
                : AppColors.black,
          );
        }),
      ),
    );
  }
}
