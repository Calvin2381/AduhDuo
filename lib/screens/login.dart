import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/FireBase/AuthFirebase.dart';
//import 'package:flutter_application_1/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/FireBase/MyAnalyticsHelper.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//var finalEmail;
//var finalPass;

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late AuthFirebase auth;

  @override
  void initState() {
    auth = AuthFirebase();
    auth.getUser().then((value) {
      MaterialPageRoute route;
      if (value != null) {
        route =
            MaterialPageRoute(builder: (context) => HomePage(wid: value.uid));
        Navigator.pushReplacement(context, route);
      }
    }).catchError((err) => print(err));
  }

  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: _loginUser,
      onRecoverPassword: _recoverPassword,
      onSignup: _onSignUp,
      passwordValidator: (value) {
        if (value != null) {
          if (value.length < 6) {
            return "Password Must Be 6 Characters";
          }
        }
      },
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: _onLoginGoogle,
        ),
      ],
      onSubmitAnimationCompleted: () {
        auth.getUser().then((value) {
          MaterialPageRoute route;
          if (value != null) {
            route = MaterialPageRoute(
                builder: (context) => HomePage(wid: value.uid));
          } else {
            route = MaterialPageRoute(builder: (context) => Login());
          }
          Navigator.pushReplacement(context, route);
        }).catchError((err) => print(err));
      },
    );
  }

  Future<String?>? _loginUser(LoginData data) {
    return auth.login(data.name, data.password).then((value) {
      if (value != null) {
        MaterialPageRoute(builder: (context) => HomePage(wid: value));
      } else {
        final snackBar = SnackBar(
          content: const Text('Login Failed, User Not Found'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

  Future<String>? _recoverPassword(String name) {
    return null;
  }

  Future<String?> _onSignUp(SignupData data) {
    return auth.signUp(data.name!, data.password!).then((value) {
      if (value != null) {
        final snackBar = SnackBar(
          content: const Text('Sign Up Successful'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  Future<String>? _onLoginGoogle() {
    return null;
  }
}

/*return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 500,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == "") {
                          return "Please Fill Your Email";
                        } else if (!regExp.hasMatch(value!)) {
                          return "Email is Invalid";
                        }
                        return "";
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obserText,
                      validator: (value) {
                        if (value == "") {
                          return "Please Fill Your Password";
                        } else if (value!.length < 8) {
                          return "Password Is Too Short";
                        }
                        return "";
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obserText = !obserText;
                              });
                            },
                            child: Icon(
                              obserText == true
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          ),
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text("Login"),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          saveData();
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text("I Don't Have Account"),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => SignUp(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            fbAnalytics.testEventLog("send_error");
                          },
                          child: Text("Send Error"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            fbAnalytics.testSetUserId("Norza");
                          },
                          child: Text("Send Event"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            fbAnalytics.testSetUserProperty();
                          },
                          child: Text("Send Property"),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );*/

/*MyAnalyticsHelper fbAnalytics = MyAnalyticsHelper();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  saveData() async {
    final localStorage = await SharedPreferences.getInstance();

    localStorage.setString('email', emailController.text.toString());
    localStorage.setString('password', passwordController.text.toString());

    var obtainedEmail = localStorage.getString('email');
    var obtainedPassword = localStorage.getString('password');
    setState(() {
      finalEmail = obtainedEmail;
      finalPass = obtainedPassword;
    });
  }*/

  /*final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
void validation() {
  final FormState? _form = _formKey.currentState;
  if (_form!.validate()) {
    print("Yes");
  } else {
    print("No");
  }
}

bool obserText = true;*/