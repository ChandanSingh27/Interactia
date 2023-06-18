import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  VoidCallback onTap;
  String text;
  Color backgroundColor;
  Color? textColor;
  bool disableButton ;
  CustomButton({super.key,required this.onTap,required this.backgroundColor,required this.text,required this.disableButton});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.disableButton? null : widget.onTap,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
            color: widget.disableButton ? widget.backgroundColor?.withOpacity(0.5) : widget.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: widget.disableButton ? widget.backgroundColor.withOpacity(0.5) : widget.backgroundColor.withOpacity(0.8),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 20
              )
            ]
        ),
        alignment: Alignment.center,
        child: Text(widget.text,style: TextStyle(color: widget.disableButton ? Colors.white.withOpacity(0.5) : Colors.white),),
      ),
    );
  }
}
