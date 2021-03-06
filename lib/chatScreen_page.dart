import 'package:chatapp/showMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class ChatScreenPage extends StatefulWidget {
  const ChatScreenPage({Key? key}) : super(key: key);

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var message = TextEditingController();
  var storeMessage = FirebaseFirestore.instance;

  getCurrentUser() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Chats',style: TextStyle
          (fontSize: 26, fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.black38, // appbar color.
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences preferences =
                await SharedPreferences.getInstance();
                Navigator.pop(context);
                preferences.clear();
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   'Message',
            //   textScaleFactor: 1.5,
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 200,),
            Container(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: ShowMessagePage())),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                    EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: message,
                      decoration: InputDecoration(
                        hintText: 'Write Message',
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if(message != null){
                        storeMessage.collection('ab').doc().set({
                          'message' : message.text.trim(),
                          'user' : loginUser!.email.toString(),
                          'time' : DateTime.now(),
                        });
                      }
                      message.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}