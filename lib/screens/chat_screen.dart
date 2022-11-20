import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';

// import 'package:flash_chat/constants.dart';
final _firestor = FirebaseFirestore.instance;
var User;

class ChatScreen extends StatefulWidget {
  static const String id = "chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textEditingController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  late String messageText;
  //print(user.uid);
  // FirebaseUser loggedInUser;
  Future<void> getCurrentUSer() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        User = user;
        print(User.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final Messages = await _firestor.collection("messages").get();
  //   for(var msg in Messages.docs){
  //     print(msg.data());
  //   }
  // }
  // void getMessageStream() async {
  //   await for (var snapshot in _firestor.collection("messages").snapshots()) {
  //     for (var msg in snapshot.docs) {
  //       print(msg.data());
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUSer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // getMessageStream();
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        messageText = textEditingController.text;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      textEditingController.clear();
                      _firestor.collection("messages").add({
                        'sender': User.email,
                        'text': messageText.toString().trim()
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  // final _firestor = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestor.collection("messages").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data?.docs.reversed;
          List<MessageBubble> messageWidget = [];
          for (var message in messages!) {
            final messageSender = message['sender'];
            final messageText = message['text'];
            final currentUser = User.email;

            final mywidget = MessageBubble(
                Sender: messageSender,
                text: messageText,
                isMe: currentUser == messageSender);
            messageWidget.add(mywidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWidget,
            ),
          );
        }
        return Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.blueAccent,
        ));
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String Sender;
  final String text;
  final bool isMe;
  MessageBubble({required this.Sender, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            Sender,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Material(
            borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(30) : Radius.circular(0),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(30)),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                text,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
