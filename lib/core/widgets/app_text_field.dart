import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_connect/core/extensions/gap_ext.dart';
import 'package:news_connect/core/themes/text_style.dart';

class AppTextFormField extends StatelessWidget {
  final String? hintText;
  final String? title;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  const AppTextFormField({
    super.key,
    this.hintText,
    this.title,
    this.inputFormatters,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.initialValue,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.focusNode,
    this.controller,
    this.maxLines = 1,
  });

  TextFormField _textField() {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? IconButton(onPressed: null, icon: prefixIcon!)
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: null, icon: suffixIcon!)
            : null,
      ),
      maxLines: maxLines,
      initialValue: initialValue,
      readOnly: readOnly,
      onTap: onTap,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return title == null
        ? _textField()
        : Column(
          
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title!, style: AppTextStyle.labelStyle),
              8.yGap,
              _textField(),
            ],
          );
  }
}
