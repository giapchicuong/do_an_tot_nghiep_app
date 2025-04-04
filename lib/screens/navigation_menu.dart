// import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// class NavigationMenu extends StatefulWidget {
//   const NavigationMenu({super.key, required this.navigationShell});
//
//   final StatefulNavigationShell navigationShell;
//
//   @override
//   State<NavigationMenu> createState() => _NavigationMenuState();
// }
//
// class _NavigationMenuState extends State<NavigationMenu> {
//   @override
//   Widget build(BuildContext context) {
//     void onTap(index) {
//       widget.navigationShell.goBranch(index,
//           initialLocation: index == widget.navigationShell.currentIndex);
//     }
//
//     return Scaffold(
//       body: widget.navigationShell,
//       bottomNavigationBar: Theme(
//         data: ThemeData(
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//         ),
//         child: BottomNavigationBar(
//           backgroundColor: AppColors.white,
//           selectedItemColor: AppColors.black,
//           unselectedItemColor: Colors.black12,
//           type: BottomNavigationBarType.fixed,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           currentIndex: widget.navigationShell.currentIndex,
//           onTap: onTap,
//           items: [
//             const BottomNavigationBarItem(
//               icon: Icon(Icons.home_rounded),
//               label: '',
//             ),
//             const BottomNavigationBarItem(
//               icon: Icon(Icons.favorite),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Container(
//                 padding: const EdgeInsets.all(15),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColors.primary,
//                 ),
//                 child: const Icon(
//                   Icons.search,
//                   color: AppColors.white,
//                 ),
//               ),
//               label: '',
//             ),
//             const BottomNavigationBarItem(
//               icon: Icon(Icons.message_outlined),
//               label: '',
//             ),
//             const BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline),
//               label: '',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:do_an_tot_nghiep/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  Widget build(BuildContext context) {
    void onTap(index) {
      widget.navigationShell.goBranch(index,
          initialLocation: index == widget.navigationShell.currentIndex);
    }

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.black,
          unselectedItemColor: Colors.black12,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: widget.navigationShell.currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            // BottomNavigationBarItem(
            //   icon: Container(
            //     padding: const EdgeInsets.all(15),
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: AppColors.primary,
            //     ),
            //     child: const Icon(
            //       Icons.camera_alt_outlined,
            //       color: AppColors.white,
            //     ),
            //   ),
            //   label: '',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
