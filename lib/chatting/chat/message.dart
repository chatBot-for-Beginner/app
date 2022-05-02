import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app1/chatting/chat/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages(this.userData, this.chatData, {Key? key}) : super(key: key);

  final Map userData;
  final Map chatData;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      // chat 내용
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;

        // 말풍선 입히기
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            // firebase로부터 가져오기
            // print(userData);
            var chatUserID = chatDocs[index]['userID'].toString();
            var userName = userData[chatUserID]['userName'];
            var userImage = userData[chatUserID]['picked_image'];
            print(userName);

            return ChatBubbles(
                chatDocs[index]['text'],
                chatDocs[index]['userID'].toString() == user!.uid,

                // chatDocs[index]['userName'],
                userName,
                // chatDocs[index]['userImage']
                userImage
            );
          },
        );
      },
    );
  }
}