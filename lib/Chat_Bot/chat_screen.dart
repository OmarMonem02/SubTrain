import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _userInput = TextEditingController();

  static const apiKey =
      "AIzaSyDlNlFivhlOAWywp_ci4wldzghh4RrEQhM"; // Replace with your actual API key

  final model =
      GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);

  final List<Message> _messages = [];

  Future<void> sendMessage() async {
    final message = _userInput.text;
    if (message.isEmpty) return; // Don't send empty messages

    setState(() {
      _messages
          .add(Message(isUser: true, message: message, date: DateTime.now()));
      _userInput.clear(); // Clear the input field
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Display messages in reverse order
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message =
                    _messages[_messages.length - 1 - index]; // Reverse index
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: _userInput,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Styles.secondaryColor,
                          width: 2,
                        ),
                      ),
                      label: const Text('Enter Your Message'),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: const EdgeInsets.all(12),
                  iconSize: 30,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor:
                        MaterialStateProperty.all(Styles.primaryColor),
                    shape: MaterialStateProperty.all(const CircleBorder()),
                  ),
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text("SubTrain Bot"),
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages(
      {super.key,
      required this.isUser,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15)
          .copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
      decoration: BoxDecoration(
          color: isUser ? Styles.primaryColor : Styles.secondaryColor,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
              topRight: const Radius.circular(10),
              bottomRight: isUser ? Radius.zero : const Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
                fontSize: 16, color: isUser ? Colors.white : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 10,
              color: isUser ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
