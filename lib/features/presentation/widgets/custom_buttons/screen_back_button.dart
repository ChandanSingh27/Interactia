import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskhub/utility/constants_color.dart';

class ScreenBackButton extends StatelessWidget {
  const ScreenBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          CupertinoIcons.back,
          color: isDark ? AppConstantsColor.white : AppConstantsColor.black,
        ),
      ),
    );
  }
}
