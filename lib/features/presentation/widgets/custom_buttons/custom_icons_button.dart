import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskhub/utility/constants_color.dart';
import 'package:taskhub/utility/constants_text.dart';

class CustomIconButton extends StatefulWidget {
  VoidCallback onTap;
  String text;
  Widget icon;
  Color backgroundColor;
  Color? textColor;
  bool enableButton;
  bool loader;
  CustomIconButton({Key? key,required this.onTap,required this.text,required this.icon,required this.backgroundColor,this.textColor,required this.loader,required this.enableButton}) : super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          width: size.width * 0.6,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.3),
            color: widget.enableButton ? widget.backgroundColor : widget.backgroundColor.withOpacity(0.5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: widget.backgroundColor?.withOpacity(0.7)??AppConstantsColor.blueLight.withOpacity(0.7),
                blurStyle: BlurStyle.outer,
                blurRadius: 5
              )
            ]
          ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(!widget.loader) SizedBox(height: 25,width: 25,child: widget.icon,),
            if(!widget.loader) const SizedBox(width: 10,),
            widget.loader ? Lottie.asset(AppConstantsText.loadingLottie):Text(widget.text,style: TextStyle(color: widget.textColor??Colors.black),),
          ],
        ),
      ),
    );
  }
}
