import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:flutter/material.dart';

class SearchtextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onSearchPressed;
  const SearchtextField({
    super.key,
    required this.controller,
    this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return TextFormField(
      style: _textTheme.headline6!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      controller: controller,
      cursorColor: CustomTheme.primaryColor,
      maxLines: 1,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      onEditingComplete: onSearchPressed,
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
          vertical: 4,
          horizontal: 12,
        ),
        counterText: "",
        hintText: "Search",
        hintStyle: _textTheme.headline6!.copyWith(
          color: CustomTheme.lightGray,
          fontSize: 14,
        ),
      ),
    );
  }
}
