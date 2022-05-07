import 'package:chatapp/chatScreen_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowMessagePage extends StatelessWidget {
  const ShowMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ab')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
            return ListTile(
              title: Column(
                crossAxisAlignment: loginUser!.email == documentSnapshot['user']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(11.0),
                    decoration: BoxDecoration(
                      color: loginUser!.email == documentSnapshot['user']
                          ? Colors.blue
                          : Colors.grey[800],
                      // border: Border.all(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      documentSnapshot['message'],
                      textScaleFactor: 1.1,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: loginUser!.email == documentSnapshot['user']
                              ? Colors.white
                              : Colors.white),
                    ),
                  ),
                  Text(
                    documentSnapshot['user'],
                    style: TextStyle(color: Colors.black26),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}