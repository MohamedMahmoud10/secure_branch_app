import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BulletPointList extends StatelessWidget {
  const BulletPointList({
    required this.points,
    super.key,
    this.textStyle,
  });

  final List<String> points;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map((String point) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '\u2022',
              style: textStyle??Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.shadow,
                    height: 1.43.h,
                  ),
            ),
             SizedBox(
              width: 8.w,
            ),
            Text(
              point,
              style: Theme.of(context).textTheme.headlineSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      }).toList(),
    );
  }
}
