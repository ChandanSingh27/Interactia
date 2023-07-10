import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../utility/constants_color.dart';

class LeftTopBlueShadow extends StatelessWidget {
  Widget bodyWidget;
  LeftTopBlueShadow({super.key,required this.bodyWidget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: -100,
          top: -100,
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppConstantsColor.blueLight.withOpacity(0.2),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 500,
                  ),
                  BoxShadow(
                    color: AppConstantsColor.blueLight.withOpacity(0.2),
                    blurStyle: BlurStyle.inner,
                    blurRadius: 500,
                  )
                ]
            ),
          ),
        ),

        // Positioned(
        //   left: -100,
        //   top: -100,
        //   child: Container(
        //     height: 250,
        //     width: 250,
        //     decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: AppConstantsColor.blueLight,
        //         boxShadow: [
        //           BoxShadow(
        //             color: AppConstantsColor.blueLight.withOpacity(0.4),
        //             blurStyle: BlurStyle.outer,
        //             blurRadius: 500,
        //           ),
        //           BoxShadow(
        //             color: AppConstantsColor.blueLight.withOpacity(0.4),
        //             blurStyle: BlurStyle.inner,
        //             blurRadius: 500,
        //           )
        //         ]
        //     ),
        // ),),
        // Positioned(
        //   right: -100,
        //   bottom: -100,
        //   child: Container(
        //     height: 250,
        //     width: 250,
        //     decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: AppConstantsColor.blueLight,
        //         boxShadow: [
        //           BoxShadow(
        //             color: AppConstantsColor.blueLight.withOpacity(0.4),
        //             blurStyle: BlurStyle.outer,
        //             blurRadius: 500,
        //           ),
        //           BoxShadow(
        //             color: AppConstantsColor.blueLight.withOpacity(0.4),
        //             blurStyle: BlurStyle.inner,
        //             blurRadius: 500,
        //           )
        //         ]
        //     ),
        //   ),),
        BackdropFilter(filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
        ),),
        bodyWidget,
      ]
    );
  }
}
