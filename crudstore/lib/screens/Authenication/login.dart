import 'package:crudstore/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmedpasswordcontroller = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                            } else {
                              User? result = await AuthServices().login(
                                  emailcontroller.text,
                                  passwordcontroller.text,
                                  context);
                              if (result != null) {
                                print("success");
                                print(result.email);
                              }
                              setState(() {
                                loading = true;
                              });
                            }
                          },
                          child: Text("Submit",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ))),
                    ),
              SizedBox(height: 20),
              TextButton(
                  onPressed: () {},
                  child: Text("Already have an account ?Login here")),
            ],
          ),
        ),
      ),
    );
  }
}
