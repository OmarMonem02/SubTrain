import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class CustomerSupportChatPage extends StatefulWidget {
  const CustomerSupportChatPage({super.key});

  @override
  State<CustomerSupportChatPage> createState() =>
      _CustomerSupportChatPageState();
}

final User? _userID = FirebaseAuth.instance.currentUser;

class _CustomerSupportChatPageState extends State<CustomerSupportChatPage> {
  List<types.Message> _messages = [];
  final _user = types.User(
    id: _userID!.uid,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "id",
      text: message.text,
    );

    _addMessage(textMessage);
  }
}
