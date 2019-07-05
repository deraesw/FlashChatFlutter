import 'package:flutter/material.dart';

const radiusDefault = 30.0;

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isSender;

  MessageBubble({key: Key, this.text, this.sender, this.isSender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(color: Colors.grey.shade800),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isSender ? Radius.circular(radiusDefault) : Radius.circular(0),
              topRight: Radius.circular(radiusDefault),
              bottomLeft: Radius.circular(radiusDefault),
              bottomRight: isSender ? Radius.circular(0) : Radius.circular(radiusDefault)
            ),
            color: isSender ? Colors.lightBlueAccent : Colors.teal,
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
