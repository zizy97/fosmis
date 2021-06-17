import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, Brightness _brightness) builder;
  ThemeBuilder({this.builder});
  @override
  _ThemeBuilderState createState() => _ThemeBuilderState();
  // ignore: non_constant_identifier_names
  static _ThemeBuilderState Of(BuildContext context) {
    return context.findAncestorStateOfType();
  }
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  final userdate = GetStorage();

  Brightness _brightness;
  @override
  void initState() {
    super.initState();
    _brightness = Brightness.light;
  }

  void changeTheme() {
    setState(() {
      _brightness =
          _brightness == Brightness.light ? Brightness.dark : Brightness.light;
      userdate.write('isdarked', isDarked());
    });
  }

  bool isDarked() {
    bool isDark = _brightness == Brightness.light ? false : true;
    return isDark;
  }

  @override
  Widget build(BuildContext context) {
    bool isdarked = userdate.read('isdarked');
    if (isdarked != isDarked()) {
      changeTheme();
    }
    return widget.builder(context, _brightness);
  }
}
