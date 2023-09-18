import 'package:crudstore/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  User user;
  AddNoteScreen(this.user);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: descriptioncontroller,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (titleController.text == "" ||
                              descriptioncontroller.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("All Fields required")));
                          } else {
                            setState(() {
                              loading = true;
                            });
                            await FirestoreService().insertNote(
                                titleController.text,
                                descriptioncontroller.text,
                                widget.user.uid);

                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Add Note",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
