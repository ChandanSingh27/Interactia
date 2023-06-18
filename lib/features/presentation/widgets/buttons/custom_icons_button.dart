import 'package:flutter/material.dart';
import 'package:taskhub/utility/constants_color.dart';

class CustomIconButton extends StatefulWidget {
  VoidCallback onTap;
  String text;
  Widget icon;
  Color? backgroundColor;
  Color? textColor;
  CustomIconButton({Key? key,required this.onTap,required this.text,required this.icon,this.backgroundColor,this.textColor}) : super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.6,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.height * 0.3),
          color: widget.backgroundColor??AppConstantsColor.blueLight,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: widget.backgroundColor?.withOpacity(0.7)??AppConstantsColor.blueLight.withOpacity(0.7),
              blurStyle: BlurStyle.outer,
              blurRadius: 20
            )
          ]
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 25,width: 25,child: widget.icon,),
          const SizedBox(width: 10,),
          Text(widget.text,style: TextStyle(color: widget.textColor??Colors.black),),
        ],
      ),
    );
  }
}
