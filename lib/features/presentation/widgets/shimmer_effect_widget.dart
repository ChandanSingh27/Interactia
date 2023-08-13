import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerEffectWidget extends StatelessWidget {
  const ShimmerEffectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 200,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  radius: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      width: 100,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      width: 200,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      width: 300,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white.withOpacity(0.2),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
    ));
  }

}
