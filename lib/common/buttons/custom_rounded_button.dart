import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:flutter/material.dart';

class CustomRoundedButtom extends StatefulWidget {
  const CustomRoundedButtom({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.padding,
    this.color,
    this.horizontalPadding = 12,
    this.verticalPadding = 16,
    this.fontSize = 14,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.w700,
    this.horizontalMargin = 0,
    this.icon,
  }) : super(key: key);
  final String title;
  final Function()? onPressed;
  final bool isLoading;
  final Color? color;
  final EdgeInsets? padding;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double horizontalMargin;
  final IconData? icon;

  @override
  CustomRoundedButtomState createState() => CustomRoundedButtomState();
}

class CustomRoundedButtomState extends State<CustomRoundedButtom> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
      child: Material(
        color: (widget.color ?? _theme.primaryColor),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: widget.padding ??
                EdgeInsets.symmetric(
                  vertical: widget.verticalPadding,
                  horizontal: widget.horizontalPadding,
                ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: widget.color ?? _theme.primaryColor,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: _theme.textTheme.headline3!.copyWith(
                      fontWeight: widget.fontWeight,
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                    ),
                  ),
                  if (widget.icon != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        widget.icon,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeOut,
                    child: widget.isLoading
                        ? Container(
                            height: 14,
                            width: 14,
                            margin: const EdgeInsets.only(left: 8),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
