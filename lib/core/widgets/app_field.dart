import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/locale_keys.g.dart';
import '../utils/extensions.dart';
import 'loading.dart';

class AppField extends StatefulWidget {
  final String? hintText, title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String? v)? validator;
  final bool isRequired, loading;
  final int maxLines;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor;
  final String? initialValue;
  final bool withBorder;
  final InputBorder? border;

  const AppField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.isRequired = true,
    this.loading = false,
    this.onTap,
    this.onChanged,
    this.maxLines = 1,
    this.suffixIcon,
    this.fillColor,
    this.prefixIcon,
    this.title,
    this.initialValue,
    this.withBorder = true,
    this.border,
  });

  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      readOnly: widget.onTap != null,
      onTap: widget.onTap,
      obscureText: widget.keyboardType == TextInputType.visiblePassword && !showPass,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: (v) {
        final RegExp regex = RegExp(r'^(00966|966|\+966|0)?5\d{8}$');
        if (widget.isRequired && v?.isEmpty == true) {
          return LocaleKeys.this_field_is_required.tr();
        } else if (widget.keyboardType == TextInputType.phone && v!.isNotEmpty && !regex.hasMatch(v)) {
          return 'رقم الجوال غير صحيح';
        } else if (widget.keyboardType == TextInputType.visiblePassword && v!.length < 8) {
          return LocaleKeys.the_password_must_not_be_less_than_8_numbers.tr();
        } else if (widget.validator != null) {
          return widget.validator?.call(v);
        }
        return null;
      },
      inputFormatters: const [],
      style: context.regularText.copyWith(fontSize: 15),
      decoration: InputDecoration(
        hintText: widget.hintText ?? LocaleKeys.write_val.tr(args: [widget.title ?? '']),
        fillColor: widget.fillColor,
        prefixIcon: buildPrefixIcon(context),
        suffixIcon: buildSuffixIcon(context),
        border: widget.border ?? (widget.withBorder ? null : InputBorder.none),
        errorBorder: widget.border ?? (widget.withBorder ? null : InputBorder.none),
        enabledBorder: widget.border ?? (widget.withBorder ? null : InputBorder.none),
        focusedBorder: widget.border ?? (widget.withBorder ? null : InputBorder.none),
        disabledBorder: widget.border ?? (widget.withBorder ? null : InputBorder.none),
        focusedErrorBorder: widget.border ?? (widget.withBorder ? null : InputBorder.none),
      ),
    );
  }

  bool showPass = false;

  buildSuffixIcon(BuildContext context) {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    } else if (widget.loading) {
      return SizedBox(
        height: 20.h,
        width: 20.h,
        child: CustomProgress(size: 15.h),
      );
    } else if (widget.onTap != null) {
      return Icon(
        Icons.keyboard_arrow_down_sharp,
        size: 18.h,
        color: context.primaryColor,
      );
    } else if (widget.keyboardType == TextInputType.visiblePassword) {
      return GestureDetector(
        onTap: () {
          setState(() {
            showPass = !showPass;
          });
        },
        child: Icon(
          showPass ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
          size: 20.w,
          color: showPass ? context.secondaryColor : context.hintColor,
        ),
      );
    }
  }

  buildPrefixIcon(BuildContext context) {
    return widget.prefixIcon?.withPadding(end: 10.w);
  }
}
