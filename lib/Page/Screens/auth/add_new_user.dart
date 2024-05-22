import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future getUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance.collection("users").doc(id).get();
  }

  Future addAnnouncementsDetails(
      Map<String, dynamic> announcementInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Announcement")
        .doc(id)
        .set(announcementInfoMap);
  }

  Future addTrainSchedule(Map<String, dynamic> scheduleInfoMap,String id) async {
    return await FirebaseFirestore.instance
        .collection("Train_Schedule")
        .doc(id)
        .set(scheduleInfoMap);
  }
}
