import 'package:flutter/material.dart';
import 'package:movies_app_task/core/constants/app_dims.dart';

import '../constants/app_colors.dart';

ThemeData getApplicationThemeData() {
  return ThemeData(
      // main colors
      primarySwatch: AppColors.amber,
      scaffoldBackgroundColor: AppColors.greyShade900,
      // app bar theme
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(color: AppColors.white, fontSize: AppDims.d20),
        color: AppColors.black,
        elevation: AppDims.d0,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      // progress indicator theme
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.amber));
}
