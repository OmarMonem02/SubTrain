import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:subtraingrad/Page/Screens/auth/add_new_data.dart';
import 'package:subtraingrad/main.dart';
import 'package:subtraingrad/widgets/bottom_nav_bar.dart';

class FirebaseNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print('token: $token');
    handleBackgroundNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState
        ?.pushNamed('/ViewAnnouncement', arguments: message);
  }

  Future<void> handleBackgroundNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

class ViewAnnouncement extends StatelessWidget {
  const ViewAnnouncement({super.key});
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    final DateFormat dateFormat = DateFormat('dd MMM yyyy - hh:mm a');
    final String formattedDate = dateFormat.format(message.sentTime!);
    final String title = message.notification?.title ?? 'No Title';
    final String body = message.notification?.body ?? 'No Body';
    final User? _user = FirebaseAuth.instance.currentUser;

    Future<void> addAnnouce() async {
      final _firebaseMessaging = FirebaseMessaging.instance;
      String? token = await _firebaseMessaging.getToken();
      String announceid = randomAlpha(10);
      Map<String, dynamic> announcementInfoMap = {
        "userID": _user!.uid,
        "tokenID": token,
        "title": title,
        "body": body,
        "date": formattedDate,
      };
      await DatabaseMethod()
          .addAnnouncementsDetails(announcementInfoMap, announceid);
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 240, 240, 240),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Text(
                      formattedDate,
                    ),
                  ],
                ),
                const Gap(12),
                Text(
                  body,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xfffdc620),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await addAnnouce();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()));
                },
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Color(0xff383d47),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Announcement"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
