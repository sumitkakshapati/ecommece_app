import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType? textInputType;
  final double bottomPadding;
  final bool obscureText;
  final bool readOnly;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.bottomPadding = 16,
    this.obscureText = false,
    this.textInputType,
    this.readOnly = false,
    this.suffixIcon,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      margin: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Text(
              label,
              style: _textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          if (label.isNotEmpty) const SizedBox(height: 12),
          Container(
            child: TextFormField(
              style: _textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              controller: controller,
              cursorColor: CustomTheme.primaryColor,
              maxLines: 1,
              keyboardType: TextInputType.text,
              obscureText: obscureText,
              readOnly: readOnly,
              validator: validator,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: CustomTheme.lightGray),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: CustomTheme.lightGray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: CustomTheme.lightGray),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: CustomTheme.lightGray),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: CustomTheme.lightGray),
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                counterText: "",
                hintText: hintText,
                hintStyle: _textTheme.headline6!.copyWith(
                  color: CustomTheme.lightGray,
                  fontSize: 14,
                ),
                suffixIcon: Icon(
                  suffixIcon,
                  size: 26,
                  color: CustomTheme.gray,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
