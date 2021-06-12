import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fosmis/Widgets/drawerWidget.dart';
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
    String state = 'FOSMIS Notify';
    final userdata = GetStorage();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(state),
          backgroundColor: Colors.purple.shade300,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Form(
                onWillPop: () => _onbackPressed(),
                key: _fkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.purple, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.purple.shade300),
                            padding: EdgeInsets.all(15),
                            // color: Colors.purple.shade300,
                            child: Text(
                              "Sign in to FOSMIS",
                              style: TextStyle(fontSize: 25.0),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: usercontrol,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter User name',
                          labelText: 'User Name',
                          suffixIcon: IconButton(
                              icon: Icon(Icons.help), onPressed: () {})),
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
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text('Reset'),
                          onPressed: () {
                            setState(() {
                              usercontrol.text = '';
                              _user = '';
                              _password = '';
                              passcontrol.text = '';
                            });
                          }, //Create OnPress Method
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          child: Text('Login'),
                          onPressed: () {
                            if (_fkey.currentState.validate()) {
                              _user = usercontrol.text;
                              _password = passcontrol.text;
                              setState(() {
                                res =
                                    LoginFOSMIS().loginFosmis(_user, _password);
                                res.then((value) => data = value);
                              });
                            }
                          }, //Create OnPress Method
                        ),
                      ],
                    ),
                    res != null
                        ? FutureBuilder(
                            future: res,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (!snapshot.data[1]) {
                                  return Text(
                                    snapshot.data[0],
                                    style:
                                        TextStyle(color: Colors.red.shade600),
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
                )),
          ),
        ),
        drawer: build_drawer(state, context: context));
  }

  IconButton _seticon() {
    return IconButton(
        icon: _obscureText ? Icon(Icons.lock) : Icon(Icons.remove_red_eye),
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
