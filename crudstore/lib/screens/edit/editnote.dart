import 'package:crudstore/model/note.dart';
import 'package:crudstore/services/firestore_services.dart';
import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  NoteModel note;
  EditNoteScreen(this.note);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    titlecontroller.text = widget.note.title;
    descriptioncontroller.text = widget.note.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
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
                controller: titlecontroller,
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
                          if (titlecontroller.text == "" ||
                              descriptioncontroller.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("All fields need to be required")));
                          } else {
                            setState(() {
                              loading = true;
                            });
                            await FirestoreService().updateNote(
                                widget.note.id,
                                titlecontroller.text,
                                descriptioncontroller.text);

                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Update Note",
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
