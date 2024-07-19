import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class AppComponent {
  static Widget customAppBar(Color color, String title, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            context.router.pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: color,
          ),
        ),
        Flexible(child: Text(title, style: AppTextStyle.mediumTitle().copyWith(color: color))),
        Visibility(
          visible: false,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Icon(
            Icons.arrow_back_ios,
            color: color,
          ),
        ),
      ],
    );
  }
}
