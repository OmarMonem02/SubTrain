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

  Future addTrainSchedule(
      Map<String, dynamic> scheduleInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Train_Schedule")
        .doc(id)
        .set(scheduleInfoMap);
  }

  Future addSubwayTicket(
      Map<String, dynamic> ticketInfoMap, String id, String UserID) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(UserID)
        .collection("Subway_tickets")
        .doc(id)
        .set(ticketInfoMap);
  }

  Future addTrainTicket(
      Map<String, dynamic> ticketInfoMap, String id, String UserID) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(UserID)
        .collection("Train_tickets")
        .doc(id)
        .set(ticketInfoMap);
  }

  Future addPrivouseTrip(Map<String, dynamic> privouseTripInfoMap, String id,
      String UserID) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(UserID)
        .collection("Privouse_Trip")
        .doc(id)
        .set(privouseTripInfoMap);
  }
}
