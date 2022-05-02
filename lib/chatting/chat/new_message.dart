import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '';

class NewMessage extends StatefulWidget {
  const NewMessage(this.cid, {Key? key}) : super(key: key);

  final String cid;
  @override
  _NewMessageState createState() => _NewMessageState(cid);
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _userEnterMessage = '';
  String? cid;

  _NewMessageState(String cid){
    this.cid = cid;
  }

  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('user')
        .doc(user!.uid).get();
    // message 서버로 전송
    final message =  await FirebaseFirestore.instance.collection('chat').add({
      'text' : _userEnterMessage,
      'time' : Timestamp.now(),
      'userID' : user.uid,
      // 'userName' : userData.data()!['userName'],
      // 'userImage' : userData['picked_image']
    });
    final message_chatting =  await FirebaseFirestore.instance
        .collection('chatting').doc(cid)
        .collection('message').add({
      'text' : _userEnterMessage,
      'time' : Timestamp.now(),
      'userID' : user.uid,
      // 'userName' : userData.data()!['userName'],
      // 'userImage' : userData['picked_image']
    });
    // message id
    // print(result.id);
    var mid = message.id;
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _userEnterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}