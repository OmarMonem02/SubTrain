import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subtraingrad/Screens/auth/auth_page.dart';
import 'package:subtraingrad/Style/app_styles.dart';
import 'package:subtraingrad/Support_Pages/Chat_Pages/chat_screen.dart';

class SupportHomePage extends StatefulWidget {
  const SupportHomePage({super.key});

  @override
  State<SupportHomePage> createState() => _SupportHomePageState();
}

class _SupportHomePageState extends State<SupportHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Support Team",
              style: MyFonts.appbar,
            ),
            TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    ),
                  );
                },
                child: Text(
                  "Logout",
                  style: MyFonts.font18Black.copyWith(color: Colors.red),
                ))
          ],
        ),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("customerSupportChat")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              children: [Text("Loading.."), CircularProgressIndicator()],
            ),
          );
        }

        // Filter out the current user and only show users who have contacted support
        List<QueryDocumentSnapshot> userDocs = snapshot.data!.docs.where((doc) {
          return doc['email'] != _auth.currentUser!.email;
        }).toList();

        return ListView(
          children:
              userDocs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => _deleteChat(document.id),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerSupportChatPage(
                  receiverUserEmail: data['email'],
                  receiverUserID: data['id'],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }

  Future<void> _deleteChat(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('customerSupportChat')
          .doc(documentId)
          .delete();
    } catch (e) {
      print("Error deleting document: $e");
    }
  }
}
