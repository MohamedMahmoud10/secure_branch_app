import 'dart:async';
import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/assets/app_images.dart';
import 'package:secure_branch_app/core/common_widgets/animated_circular_progress_indicator.dart';
import 'package:secure_branch_app/core/const/const_strings.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/core/helpers/app_helper_functions.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    Timer(const Duration(seconds: 4), () async {
      await AppHelperFunctions().checkCachedKeysAndNavigate();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        children: <Widget>[
          const Positioned.fill(child: _GridBackground()),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _rotateAnimation,
                      builder: (BuildContext context, Widget? child) {
                        return Transform.rotate(
                          angle: _rotateAnimation.value,
                          child: Container(
                            width: 190.w,
                            height: 190.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.biometric.withValueOpacity(
                                  0.5,
                                ),
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeOutCubic,
                      builder:
                          (BuildContext context, double value, Widget? child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.scale(
                                scale: 0.8 + (0.2 * value),
                                child: child,
                              ),
                            );
                          },
                      child: Container(
                        width: 160.w,
                        height: 160.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36.r),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: AppColors.primary.withValueOpacity(0.6),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage(AppImages.appIcon),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),

                Text(
                  AppStrings.applicationName.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primaryWhite,
                    letterSpacing: 8,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 80.h,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                const Center(child: AnimatedCircularProgressIndicator()),
                SizedBox(height: 16.h),
                Text(
                  LocaleKeys.establishingSecureConnection.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.biometric.withValueOpacity(0.5),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridBackground extends StatelessWidget {
  const _GridBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GridPainter(
        color: AppColors.primaryLight.withValueOpacity(0.05),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;

  _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;
    const double spacing = 40;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
