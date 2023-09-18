import 'package:crudstore/screens/Authenication/login.dart';
import 'package:crudstore/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmedpasswordcontroller = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Regsiter"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                obscureText: true,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  labelText: "password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                obscureText: true,
                controller: confirmedpasswordcontroller,
                decoration: InputDecoration(
                  labelText: "confirme password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              loading
                  ? CircularProgressIndicator()
                  : Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            if (emailcontroller.text == "" ||
                                passwordcontroller.text == "") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("All Fields Are Required !"),
                                backgroundColor: Colors.red,
                              ));
                            } else if (passwordcontroller.text !=
                                confirmedpasswordcontroller.text) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Passwords are Not mathed!"),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              User? result = await AuthServices().resgister(
                                  emailcontroller.text,
                                  passwordcontroller.text,
                                  context);
                              if (result != null) {
                                print("success");
                                print(result.email);
                              }
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Text("Submit",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ))),
                    ),
              SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("Already have an account ?Login here")),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              loading
                  ? CircularProgressIndicator()
                  : SignInButton(Buttons.Google, text: "continue with Google",
                      onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await AuthServices().signInWithGoogle();

                      setState(() {
                        loading = false;
                      });
                    })
            ]),
          ),
        ),
      ),
    );
  }
}
