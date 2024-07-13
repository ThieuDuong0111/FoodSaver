import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/core/utils/validate_utils.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/presentation/pages/category_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/pages/home_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/image_parse.dart';
import 'package:funix_thieudvfx_foodsaver/features/init/presentation/riverpod/user_info_notifier.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/presentation/pages/my_profile_page.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_colors.dart';

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
        child: Consumer(
          builder: (context, ref, child) {
            final UserEntity userinfo = ref.watch(UserInfoNotifier.provider).userInfo;

            return BottomNavigationBar(
              selectedFontSize: 12.sp,
              unselectedFontSize: 12.sp,
              selectedItemColor: AppColors.primaryBrand,
              unselectedItemColor: AppColors.greyColor,
              backgroundColor: Colors.white,
              elevation: 1,
              type: BottomNavigationBarType.fixed,
              currentIndex: bottomSelectedIndex,
              onTap: bottomTapped,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category_outlined,
                  ),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: ValidateUtils.isNotNullOrEmpty(userinfo.imageUrl)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(24.w),
                          child: ImageParse(width: 24.w, height: 24.w, url: userinfo.imageUrl, type: 'user'),
                        )
                      : const Icon(
                          Icons.account_circle,
                        ),
                  label: 'Profile',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
