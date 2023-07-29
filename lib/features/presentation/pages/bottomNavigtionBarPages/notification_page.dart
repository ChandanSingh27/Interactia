import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "Notification",
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
      ),
    ),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/notification_lottie.json",width: 200,height: 200,repeat: false),
          const Text("No Notification"),
        ],
      ),
    ),  
    );
  }
}
