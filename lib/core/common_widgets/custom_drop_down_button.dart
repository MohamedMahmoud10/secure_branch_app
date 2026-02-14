import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/core/extensions/widgets_extensions.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  final List<T> items;
  final String hintText;
  final void Function(T? newItem) onChanged;
  final T? initialItem;
  final String? Function(T?)? validator;
  final String? suffix;
  final double? height;
  final double? width;
  final String labelText;
  final bool? hasShadow;

  const CustomDropDownButton({
    required this.hintText,
    required this.items,
    required this.onChanged,
    required this.labelText,
    this.initialItem,
    this.validator,
    this.suffix,
    this.height,
    this.width,
    this.hasShadow = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: Text(
            labelText,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ).paddingHorizontal(20.w),
        SizedBox(height: 6.h),
        SizedBox(
          width: width ?? 345.w,
          height: height ?? 65.h,
          child: CustomDropdown<T>(
            closedHeaderPadding:
                EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
            initialItem: initialItem,
            excludeSelected: false,
            itemsListPadding: EdgeInsets.zero,
            listItemBuilder: suffix != null
                ? (_, T item, ___, ____) {
                    return Text(
                      '$item $suffix',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    );
                  }
                : null,
            headerBuilder: suffix != null
                ? (BuildContext context, T? selectedItem, __) {
                    return Text(
                      '$selectedItem $suffix',
                      style: Theme.of(context).textTheme.labelSmall,
                    );
                  }
                : null,
            decoration: CustomDropdownDecoration(
              listItemDecoration: ListItemDecoration(
                selectedColor:  Colors.grey[300],
                highlightColor: Colors.grey[100],
              ),
              closedBorderRadius: BorderRadius.circular(8.r),
              closedErrorBorderRadius: BorderRadius.circular(8.r),
              expandedBorderRadius: BorderRadius.circular(8.r),
              closedBorder: Border.all(
                color: Theme.of(context).colorScheme.surfaceBright,
                width: 1.w,
              ),
              closedFillColor: Theme.of(context).colorScheme.primary,
              expandedFillColor: Theme.of(context).colorScheme.primary,

              ///Items Inside DropDown
              listItemStyle: Theme.of(context).textTheme.labelSmall,
              headerStyle: Theme.of(context).textTheme.labelSmall,
              expandedBorder: Border.all(
                color: Theme.of(context).colorScheme.surfaceBright,
                width: 1.w,
              ),
              hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  ),
            ),

            hintText: hintText,
            items: items,
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
