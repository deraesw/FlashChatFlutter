import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flash_chat/constants.dart';
import 'package:flash_chat/widget/message_bubble_widget.dart';

class ChatScreen extends StatefulWidget {
  static const String pathName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _store = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final _messageTextController = TextEditingController();

  String _message;
  FirebaseUser _firebaseUser;

  @override
  void initState() {
    super.initState();

    _getFirebaseUser();
  }

  void _getFirebaseUser() async {
    try {
      _firebaseUser = await _auth.currentUser();
      if (_firebaseUser != null) {
        print(_firebaseUser.email);
      } else {
        print('error');
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  void _signOut() async {
    await _auth.signOut();
    Navigator.pop(context);
  }

  void _sendMessage() {
    if(_message.isEmpty) {
      return;
    }

    try {
      _store
          .collection('messages')
          .add({'text': _message, 'sender': _firebaseUser.email});
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _signOut();
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
            buildMessageList(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _messageTextController,
                      onChanged: (value) {
                        _message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _messageTextController.clear();
                      _sendMessage();
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

  Expanded buildMessageList() {
    return Expanded(
      child: StreamBuilder(
        stream: _store.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //TODO
            return Center(
              child: Text('snapshot.hasError'),
            );
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              print('Select lot');
              break;
            case ConnectionState.waiting:
              print('Awaiting bids...');
              break;
            case ConnectionState.active:
              print('\$${snapshot.data}');
              break;
            case ConnectionState.done:
              print('\$${snapshot.data} (closed)');
              break;
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text('snapshot.noData'),
            );
          }

          List<MessageBubble> messageBubble = List();

          for (var documents in snapshot.data.documents) {
            messageBubble.add(MessageBubble(
              text: documents.data['text'],
              sender: documents.data['sender'],
              isSender: documents.data['sender'] == _firebaseUser.email,
            ));
          }

          return ListView.builder(
            itemCount: messageBubble.length,
            itemBuilder: (context, index) {
              return messageBubble[index];
            },
          );
        },
      ),
    );
  }
}
