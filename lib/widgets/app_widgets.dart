import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppWidgets {
  static const Color themeColor = Color.fromARGB(255, 15, 75, 140);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color textfieldLabel = Color.fromARGB(255, 0, 4, 8);
  static const Color borderColor = Color(0xFFEAEAEA);
  static const Color textColor = Color(0xFF19212C);

  static Widget text(
      String string, FontWeight fontWeight, Color fontColor, double fontSize,
      {TextDecoration decoration = TextDecoration.none,
      TextAlign align = TextAlign.justify}) {
    return Text(
      string,
      textAlign: align,
      style: TextStyle(
          decoration: decoration,
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: fontColor),
    );
  }

  static Widget labelledTextField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
    required TextInputType keyboardType,
    required int maxLength,
    required String hint,
    Widget? suffixIcon,
    required bool isObscureText,
    bool enabled = true,
    bool autofocus = false,
    List<TextInputFormatter>? inputFormatter,
    TextInputAction? textInputAction,
    Color borderColor = AppWidgets.borderColor,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    double height = 48,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppWidgets.text(label, FontWeight.w500, AppWidgets.textfieldLabel, 16),
        const SizedBox(
          height: 11,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: height,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  // color: backgroundColor,
                  border: Border.all(
                      color: borderColor, width: 1), // set border width
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8.0)), // set rounded corner radius
                ),
                child: TextFormField(
                  textCapitalization: textCapitalization,

                  enabled: enabled,
                  autofocus: autofocus,
                  controller: controller,
                  inputFormatters: inputFormatter,
                  obscureText: isObscureText,
                  onChanged: onChanged,

                  textInputAction: textInputAction,
                  keyboardType: keyboardType,
                  // maxLines: isObscureText ? 1 : null,
                  style: textStyle ??
                      const TextStyle(
                        color: AppWidgets.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                      ),
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    hintStyle: hintTextStyle ??
                        const TextStyle(
                          color: AppWidgets.textfieldLabel,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Inter",
                        ),
                    suffixIcon: suffixIcon,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget elevatedButton({
    required String buttonName,
    required double fontSize,
    required double width,
    required double height,
    required Color color,
    required Color textColor,
    VoidCallback? onPressed,
  }) {
    final ButtonStyle flatButtonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(width, height),
      elevation: 0,
      primary: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
    );
    return ElevatedButton(
      style: flatButtonStyle,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppWidgets.text(buttonName, FontWeight.w600, textColor, fontSize),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
