import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fosmis/pages/home.dart';
import 'package:fosmis/Services/login_fosmis.dart';
import 'package:get_storage/get_storage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _fkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List> res;
  String _user, _password;
  List data;
  bool _obscureText = true;
  TextEditingController usercontrol = TextEditingController();
  TextEditingController passcontrol = TextEditingController();

  Future<bool> _onbackPressed() {
    _scaffoldKey.currentState.isDrawerOpen
        ? Navigator.pop(context)
        : showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Do you want to exit?'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('No')),
                ElevatedButton(
                    onPressed: () => SystemChannels.platform
                        .invokeMethod('SystemNavigator.pop'),
                    child: Text('Exit'))
              ],
            ),
          );
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //String state = 'FOSMIS Notify';
    final userdata = GetStorage();

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            // color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "F O S M I S",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.06,
                      color: Colors.purple,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Arial'),
                ),
              ],
            ),
          ),
          Form(
              onWillPop: () => _onbackPressed(),
              key: _fkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usercontrol,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.person),
                            hintText: 'Enter User name',
                            labelText: 'User Name',
                          ),
                          validator: (user) {
                            if (user.isEmpty) {
                              return 'User name Cannot Empty';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _user = value;
                          },
                        ),
                        TextFormField(
                          controller: passcontrol,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.lock),
                              hintText: 'Enter a password',
                              labelText: 'Password',
                              suffixIcon: _seticon()),
                          obscureText: _obscureText,
                          onChanged: (value) {
                            _password = value;
                          },
                          validator: (pass) {
                            if (pass.isEmpty) {
                              return "Password Cannot Empty";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ElevatedButton(
                    child: Text('Login'),
                    onPressed: () {
                      if (_fkey.currentState.validate()) {
                        _user = usercontrol.text;
                        _password = passcontrol.text;
                        setState(() {
                          res = LoginFOSMIS().loginFosmis(_user, _password);
                          res.then((value) => data = value);
                        });
                      }
                    }, //Create OnPress Method
                  ),
                  res != null
                      ? FutureBuilder(
                          future: res,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (!snapshot.data[1]) {
                                return Text(
                                  snapshot.data[0],
                                  style: TextStyle(color: Colors.red.shade600),
                                );
                              } else {
                                userdata.write('isLogged', true);
                                userdata.write('uname', _user);
                                userdata.write('upwd', _password);
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(),
                                      ));
                                });
                                return Container();
                              }
                            } else {
                              return LinearProgressIndicator();
                            }
                          },
                        )
                      : Text("")
                ],
              ))
        ]),
      ),
    );
    // drawer: build_drawer(state, context: context));
  }

  IconButton _seticon() {
    return IconButton(
        icon:
            _obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
        onPressed: _toggle);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      usercontrol.text = _user;
      passcontrol.text = _password;
    });
  }
}
