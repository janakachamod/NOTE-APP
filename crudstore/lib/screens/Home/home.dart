import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudstore/model/note.dart';
import 'package:crudstore/screens/add/addnote.dart';
import 'package:crudstore/screens/edit/editnote.dart';
import 'package:crudstore/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  User user;
  Home(this.user);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.logout),
            label: Text("Sign Out"),
            style: TextButton.styleFrom(primary: Colors.white),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("notes")
            .where('userId', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  NoteModel note =
                      NoteModel.fromJson(snapshot.data.docs[index]);
                  return Card(
                    color: Colors.teal,
                    elevation: 0.0,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      title: Text(
                        note.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        note.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditNoteScreen(note),
                        ));
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("No notes available"),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNoteScreen(user),
          ));
        },
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
