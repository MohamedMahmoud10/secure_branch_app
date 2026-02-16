import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';

class CustomTextFormField extends HookWidget {
  const CustomTextFormField({
    required this.textEditingController,
    this.hintText,
    super.key,
    this.keyboardType,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.focusNode,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    this.icon,
    this.obscureText = false,
    this.readOnly = false,
    this.inputFormatters,
    this.textFieldName = '',
    this.maxLines,
    this.initialValue = '',
    this.autoFocus = false,
    this.enabled,
    this.onSuffixIconPressed,
    this.paddingLeft,
    this.paddingRight,
    this.fillColor,
    this.hintStyle,
    this.height,
    this.labelTextColor,
    this.isProductApp = true,
    this.autoValidateMode,
    this.maxLength,
    this.keyboardAction,
  });

  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final ValueSetter<String?>? onChanged;

  final GestureTapCallback? onTap;
  final ValueChanged<String?>? onFieldSubmitted;
  final ValueSetter<String?>? onSaved;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final Widget? icon;
  final bool readOnly;
  final List<dynamic>? inputFormatters;
  final String textFieldName;
  final int? maxLines;
  final String? initialValue;
  final bool? autoFocus;
  final bool? enabled;
  final GestureTapCallback? onSuffixIconPressed;
  final double? paddingLeft;
  final double? paddingRight;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final double? height;
  final Color? labelTextColor;
  final bool? isProductApp;
  final AutovalidateMode? autoValidateMode;
  final int? maxLength;
  final TextInputAction? keyboardAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (labelText != null)
          Text(labelText!, style: Theme.of(context).textTheme.labelSmall)
        else
          const SizedBox.shrink(),
        SizedBox(height: 8.h),
        Theme(
          data: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              surface: Theme.of(context).colorScheme.primaryContainer,
              onSurface: AppColors.primaryBlack,
              primary: AppColors.primary,
            ),
          ),
          child: FormBuilderTextField(
            enabled: enabled ?? true,
            onTapOutside: (PointerDownEvent event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            maxLines: maxLines ?? 1,
            name: textFieldName,
            inputFormatters: const <TextInputFormatter>[],
            readOnly: readOnly,
            obscureText: obscureText,
            controller: textEditingController,
            focusNode: focusNode,
            onChanged: onChanged,
            onTap: onTap,
            onSubmitted: onFieldSubmitted,
            validator: validator,
            onSaved: onSaved,
            keyboardType: keyboardType,
            autofocus: autoFocus ?? false,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.primaryBlack
            ),
            autovalidateMode: autoValidateMode,
            maxLength: maxLength,
            textInputAction: keyboardAction,
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            decoration: InputDecoration(
              constraints: BoxConstraints(
                maxHeight: height ?? 150.h,
                minHeight: height ?? 60.h,
              ),
              filled: true,
              fillColor: fillColor ?? Theme.of(context).colorScheme.primary,
              hintText: hintText,
              hintStyle:
                  hintStyle ??
                  Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.textHint),
              helperText: ' ',
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              contentPadding: contentPadding,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(8.0.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.textHint,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(8.0.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.3),
                borderRadius: BorderRadius.circular(8.0.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.3),
                borderRadius: BorderRadius.circular(8.0.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
