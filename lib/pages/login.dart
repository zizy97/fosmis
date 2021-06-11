import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fosmis/Widgets/drawerWidget.dart';
import 'package:fosmis/pages/home.dart';
import 'package:fosmis/practice/login_fosmis.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _fkey = GlobalKey<FormState>();
  Future<List> res;
  String _user, _password = '';
  @override
  Widget build(BuildContext context) {
    String state = 'FOSMIS Notify';
    return Scaffold(
        appBar: AppBar(
          title: Text(state),
          backgroundColor: Colors.purple.shade300,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Form(
                key: _fkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter User name',
                          labelText: 'User Name'),
                      validator: (user) {
                        if (user.isEmpty) {
                          return 'User name Cannot Empty';
                        }
                        return null;
                      },
                      onSaved: (user) {
                        _user = user;
                        print(_user);
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.lock),
                        hintText: 'Enter a password',
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (pass) {
                        if (pass.isEmpty) {
                          return "Password Cannot Empty";
                        }
                        return null;
                      },
                      onSaved: (pass) {
                        _password = pass;
                        print(_password);
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text('Login'),
                          onPressed: () {
                            if (_fkey.currentState.validate()) {
                              _fkey.currentState.save();
                              setState(() {
                                res =
                                    LoginFOSMIS().loginFosmis(_user, _password);
                              });
                            }
                          }, //Create OnPress Method
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                    res != null
                        ? FutureBuilder(
                            future: res,
                            // ignore: missing_return
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (!snapshot.data[1]) {
                                  return Text(
                                    snapshot.data[0],
                                    style:
                                        TextStyle(color: Colors.red.shade600),
                                  );
                                } else {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Home(),
                                        ));
                                  });
                                }
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          )
                        : Text("")
                  ],
                )),
          ),
        ),
        drawer: build_drawer(state));
  }
}
