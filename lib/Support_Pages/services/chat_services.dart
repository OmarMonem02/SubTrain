import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/Support_Pages/model/message.dart';

class ChatServices extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //send messages

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      timestamp: timestamp,
      message: message,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());

    // Update customerSupportChat collection to include the latest message or user chat
    await _fireStore.collection('customerSupportChat').doc(currentUserId).set({
      'email': currentUserEmail,
      'id': currentUserId,
      'lastMessage': message,
      'timestamp': timestamp,
    });
  }

/*
  Future<void> sendMessage(String receiverId, String message) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create new Message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        timestamp: timestamp,
        message: message);

    //constract chatroom
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());
  }
*/
  //get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
