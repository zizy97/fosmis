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
  Future<List> res;
  String _user, _password;
  List data;

  Future<bool> _onbackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to exit?'),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('No')),
          ElevatedButton(
              onPressed: () =>
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              child: Text('Exit'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String state = 'FOSMIS Notify';
    final userdata = GetStorage();
    TextEditingController usercontrol = TextEditingController();
    TextEditingController passcontrol = TextEditingController();
    return Scaffold(
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
                    SizedBox(
                      height: 100,
                    ),
                    TextFormField(
                      controller: usercontrol,
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
                    ),
                    TextFormField(
                      controller: passcontrol,
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
