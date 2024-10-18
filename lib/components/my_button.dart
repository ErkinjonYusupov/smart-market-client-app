import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton(
      {super.key,
      required this.buttonName,
      required this.onPressed,
      this.color = const Color(0xff9D81FF),
      this.textColor = const Color(0xffffffff)});
  final String buttonName;
  final Function() onPressed;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(

          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          )),
          backgroundColor: WidgetStatePropertyAll<Color>(color!),
          elevation: WidgetStateProperty.resolveWith<double>(
            // As you said you dont need elevation. I'm returning 0 in both case
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return 0;
              }
              return 0; // Defer to the widget's default.
            },
          ),
        ),
        child: Text(
          buttonName,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
    );
  }
}
