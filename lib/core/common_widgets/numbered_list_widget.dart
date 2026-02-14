import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberedListWidget extends StatelessWidget {
  final List<String> items;
final TextStyle?textStyle;
  const NumberedListWidget({
    required this.items,
    super.key, this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(items.length, (int index) {
        return Text(
          '${index + 1}. ${items[index]}',
          style:textStyle?? Theme.of(context).textTheme.labelSmall,
        );
      }),
    );
  }
}
