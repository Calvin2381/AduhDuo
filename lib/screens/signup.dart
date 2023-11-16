import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool obserText = true;

class _SignUpState extends State<SignUp> {
  void validation() {
    final FormState? _form = _formKey.currentState;
    if (_form!.validate()) {
      print("Yes");
    } else {
      print("No");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
            child: Column(
          children: <Widget>[
            Container(
              height: 220,
              width: double.infinity,
              color: Color.fromARGB(255, 70, 77, 83),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 400,
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 8) {
                        return "Username Is Too Short";
                      } else if (value == "") {
                        return "Please Fill Username";
                      }
                      return "";
                    },
                    decoration: InputDecoration(
                      hintText: "Username",
                      icon: Icon(Icons.people_alt),
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    obscureText: obserText,
                    validator: (value) {
                      if (value == "") {
                        return "Please Fill Password";
                      } else if (value!.length < 8) {
                        return "Password Is Too Short";
                      }
                      return "";
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      icon: Icon(Icons.key),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obserText = !obserText;
                          });
                          FocusScope.of(context).unfocus();
                        },
                        child: Icon(
                          obserText == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == "") {
                        return "Please Fill Phone Number";
                      } else if (value!.length < 11) {
                        return "Phone Number Must Be 11 Digit";
                      }
                      return "";
                    },
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      icon: Icon(Icons.phone),
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == "") {
                        return "Please Fill Email";
                      } else if (!regExp.hasMatch(value!)) {
                        return "Email Is Invalid";
                      }
                      return "";
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      icon: Icon(Icons.mail),
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text("Register"),
                        onPressed: () {
                          validation();
                        }),
                  ),
                  Row(
                    children: [
                      Text("I Have Already An Account"),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => Login(),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.cyan,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
