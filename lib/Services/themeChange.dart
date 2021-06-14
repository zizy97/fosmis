import 'package:flutter/material.dart';

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
    });
  }

  bool isDarked() {
    bool isDark = _brightness == Brightness.light ? false : true;
    return isDark;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _brightness);
  }
}
