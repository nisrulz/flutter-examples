import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? text;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;
  final InputBorder? border;
  final FloatingLabelBehavior floatingLabelBehavior;
  final ValueChanged<String>? onSubmit;
  final String? prefixText;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final FocusNode? focusNode;
  final int? maxLength;
  final List<TextInputFormatter> inputFormatters;
  final String? errorText;
  final Color? fillColor;
  final bool filled;
  final bool enabled;
  final EdgeInsets? contentPadding;
  final bool editable;
  final bool useCustomLabel;
  final bool isDense;
  final AutovalidateMode? autoValidateMode;
  final String? counterText;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.text,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.maxLines = 1,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.sentences,
    this.controller,
    this.border,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.onSubmit,
    this.prefixText,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.focusNode,
    this.maxLength,
    this.inputFormatters = const [],
    this.enabled = true,
    this.errorText,
    this.fillColor = Colors.white,
    this.filled = false,
    this.contentPadding,
    this.editable = true,
    this.useCustomLabel = false,
    this.isDense = true,
    this.autoValidateMode,
    this.counterText,
  });

  @override
  Widget build(BuildContext context) {
    if (!editable) {
      return _buildNonEditableTextField(context);
    }

    final textField = TextFormField(
      key: hint != null ? Key(hint!) : null,
      onChanged: onChanged,
      initialValue: text,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      controller: controller,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      focusNode: focusNode,
      maxLength: maxLength,
      enabled: enabled,
      autovalidateMode: autoValidateMode,
      inputFormatters: [
        ...inputFormatters,
        if (keyboardType == TextInputType.number)
          FilteringTextInputFormatter.digitsOnly,
      ],
      onFieldSubmitted: (v) {
        if (onSubmit != null) {
          FocusScope.of(context).nextFocus();
        }
        onSubmit?.call(v);
      },
      decoration: InputDecoration(
        isDense: isDense,
        hintText: hint,
        labelText: useCustomLabel ? null : label,
        floatingLabelBehavior: floatingLabelBehavior,
        border: border ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
        enabledBorder: border ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        errorText: errorText,
        counterText: counterText,
        suffixIconConstraints:
            const BoxConstraints(maxWidth: 30, maxHeight: 30),
        fillColor: fillColor,
        contentPadding: contentPadding,
        filled: filled,
      ),
    );

    if (useCustomLabel) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomLabelText(label ?? 'Label'),
          SizedBox(height: 3),
          textField,
        ],
      );
    }

    return textField;
  }

  Widget _buildNonEditableTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCustomLabelText(label ?? 'Label'),
        SizedBox(height: 3),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Get.isDarkMode ? null : Colors.grey.shade200,
            border: border != null ? Border.all(color: Colors.grey) : null,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Padding(
            padding: EdgeInsets.all(13),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                text ?? '',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        if (errorText?.isNotEmpty ?? false)
          Text(
            errorText!,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildCustomLabelText(String value) {
    return Text(
      value,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
