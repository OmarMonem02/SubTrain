import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/Support_Pages/services/chat_services.dart';
import 'package:subtraingrad/widgets/chat_bubble.dart';

class CustomerSupportChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const CustomerSupportChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID});

  @override
  State<CustomerSupportChatPage> createState() =>
      _CustomerSupportChatPageState();
}

class _CustomerSupportChatPageState extends State<CustomerSupportChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatServices _chatServices = ChatServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Support",
          style: MyFonts.appbar,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),

          // user input
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatServices.getMessages(
            widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: [Text("Loading.."), CircularProgressIndicator()],
              ),
            );
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: alignment == Alignment.centerRight
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 5),
            ChatBubble(
              color: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? Styles.primaryColor
                  : Styles.secondaryColor,
              fontstyle: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MyFonts.font16White
                  : MyFonts.font16White,
              message: data['message'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: SubTextField(
                controller: _messageController,
                hint: "Enter Message",
                textLabel: "Message",
                textInputType: TextInputType.text,
                enable: true),
          ),
          IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send,
                size: 40,
              ))
        ],
      ),
    );
  }
}
