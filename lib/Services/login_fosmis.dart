import 'package:http/http.dart' as http;

class LoginFOSMIS {
  var client = http.Client();
  Future<List> loginFosmis(String uname, String pass) async {
    try {
      Map data = {'uname': uname, 'upwd': pass};
      var url = Uri.parse("https://paravi.ruh.ac.lk/fosmis2020/login.php");
      var response = await client.post(url, body: data);
      String cookie = response.headers['set-cookie'];

      var body = '';

      await client.get(
          Uri.parse("https://paravi.ruh.ac.lk/fosmis2020/forms/form_53_a.php"),
          headers: {'Cookie': cookie}).then((response) => body = response.body);

      var regex = RegExp(r'You Have Not Permission To Access This Area!',
          caseSensitive: false);
      Iterable<RegExpMatch> error = regex.allMatches(body);
      var flag = false;
      // ignore: unused_local_variable
      for (Match m in error) {
        flag = true;
      }

      if (error != null && flag) {
        return ["Username or Password Incorrect!!!", false];
      } else {
        return ["Connection Stablished!!!", true];
      }
    } catch (e) {
      return ["Connection Error!!!", false];
    }
  }
}
