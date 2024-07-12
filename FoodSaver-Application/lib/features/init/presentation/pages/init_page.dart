import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/presentation/pages/category_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/pages/home_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/presentation/pages/my_profile_page.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class InitPage extends StatefulWidget {
  const InitPage({
    super.key,
  });

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int index = 0;
  int bottomSelectedIndex = 0;
  PageController pageController = PageController();

  Future<void> bottomTapped(int index) async {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 1),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [HomePage(), CategoryPage(), MyProfilePage()],
      ),
      bottomNavigationBar: Container(
        // height: 46.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFC0B7B7),
            ),
          ),
        ),
        child: BottomNavigationBar(
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          selectedItemColor: AppColors.primaryBrand,
          unselectedItemColor: AppColors.greyColor,
          // selectedLabelStyle: AppTextStyle.primaryText().copyWith(color: AppColors.primaryBrand),
          // unselectedLabelStyle: AppTextStyle.primaryText().copyWith(color: AppColors.greyColor),
          backgroundColor: Colors.white,
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomSelectedIndex,
          onTap: bottomTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
              ),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
