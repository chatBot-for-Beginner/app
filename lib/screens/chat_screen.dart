import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app1/chatting/chat/message.dart';
import 'package:chat_app1/chatting/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  String? cid;  // chatting room id
  //userdata 담을 맵 자료횽
  Map userData = {};
  //chatdata 담을 맵 자료횽
  Map chatData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();


  }

  Future<void> getCurrentUser() async {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
      // 현재 로그인 유저의 데이터
      // await FirebaseFirestore.instance
      //     .collection('user')
      //     .doc(loggedUser!.uid)
      //     .get()
      //     .then((DocumentSnapshot documentSnapshot) {
      //   if (documentSnapshot.exists) {
      //     print('Document exists on the database');
      //     userData = documentSnapshot.data();
      //   }
      // });
      // print(userData['email']);

      //전체 유저의 데이터
      await FirebaseFirestore.instance
          .collection('user')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // print(doc.data());
          // print(doc.id);
          // map데이터 삽입
          userData[doc.id] = doc.data();
        });
      });
      print("로그인 계정: ${userData[loggedUser!.uid]['email']}");

      // 전체 chat 데이터
      await FirebaseFirestore.instance
          .collection('chat')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // print(doc.data());
          // print(doc.id);
          // map데이터 삽입
          chatData[doc.id] = doc.data();
        });
      });

      // chatbot의 chat text 출력
      for (Map chat in chatData.values) {
        if(chat['userID'] == 'dNRSFrdJpYfTwRTe4uvQa6jTsuw2'){
          print(chat['text']);
        };
      };


    } catch (e) {
      print(e);
    }
  }



  // void getCurrentChatting(){
  //   try{
  //     FirebaseFirestore.instance.collection('chatting').
  //
  //   }
  // }

  // chat_screen widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat screen'),
        actions: [
          // logout 버튼
          IconButton(
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              _authentication.signOut();
              //Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              // 채팅 기록
              child: Messages(),
            ),
            // 채팅 입력창
            NewMessage(),
          ],
        ),
      ),
    );
  }
}