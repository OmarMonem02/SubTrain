import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/widgets/announce_post.dart';

class Announcements extends StatelessWidget {
  const Announcements({super.key});

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnnouncementPost(
              date: message.sentTime.toString(),
              header: message.notification!.title.toString(),
              massage: message.notification!.body.toString(),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Announcements",
        ),
      ),
    );
  }
}
