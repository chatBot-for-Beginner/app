import 'package:chat_app1/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  String? cid;
  bool darkMode = false;
  
  void _setCID() async {
    final user = _authentication.currentUser;
    this.loggedUser = user;
    var uid = await this.loggedUser!.uid;
    print(uid);
    await FirebaseFirestore.instance
        .collection('chatting')
        .where('userID',isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // print("doc:");
        // print(doc.id);
        // print(doc.data());
        this.cid = doc.id;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.grey[850] : Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                print("chatstart tap");
                // _setCID();
                // dksl tbqjf 함수 좀 쓰자고 ㅋㅋㅋ
                final user = _authentication.currentUser;
                this.loggedUser = user;
                var uid = await this.loggedUser!.uid;
                print(uid);
                await FirebaseFirestore.instance
                    .collection('chatting')
                    .where('userID',isEqualTo: uid)
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                  querySnapshot.docs.forEach((doc) {
                    // print("doc:");
                    // print(doc.id);
                    // print(doc.data());
                    this.cid = doc.id;
                  });
                });
                print(this.cid);

                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChatScreen(this.cid!);
                      },
                    ),
                  );
                });
              },
              child: Container(
                width: 350,
                height: 150,
                child: Center(child: Text('chat start', style: TextStyle(color: darkMode? Colors.white : Colors.black, fontSize: 30),)),
                decoration: BoxDecoration(
                    color: darkMode ? Colors.grey[850] : Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: darkMode ? (Colors.black54)! : (Colors.grey[500])!,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                      BoxShadow(
                          color: darkMode ? (Colors.grey[800])! : (Colors.white)!,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                    ]),
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: Container( ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  print("tap");
                  darkMode = !darkMode;
                });
              },
              child: Container(
                width: 350,
                height: 150,
                child: Center(child: Text('option', style: TextStyle(color: darkMode? Colors.white : Colors.black, fontSize: 30),)),
                decoration: BoxDecoration(
                    color: darkMode ? Colors.grey[850] : Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: darkMode ? (Colors.black54)! : (Colors.grey[500])!,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                      BoxShadow(
                          color: darkMode ? (Colors.grey[800])! : (Colors.white)!,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                    ]),
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: Container( ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  print("tap");
                  darkMode = !darkMode;
                });
              },
              child: Container(
                width: 350,
                height: 150,
                child: Icon(Icons.sunny, size: 80, color: darkMode ? Colors.white : Colors.black),
                decoration: BoxDecoration(
                    color: darkMode ? Colors.grey[850] : Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: darkMode ? (Colors.black54)! : (Colors.grey[500])!,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                      BoxShadow(
                          color: darkMode ? (Colors.grey[800])! : (Colors.white)!,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                    ]),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
