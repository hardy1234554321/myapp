import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demo'),
        ),
        body: formSection(),
      ),
    );
  }
}

class formSection extends StatefulWidget {
  @override
  State<formSection> createState() => formSectionState();
}

class formSectionState extends State<formSection> {
  bool _isEnabled = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController loginController = TextEditingController();

  void buttonClicksEvent() {
    setState(() {
      _isEnabled = !_isEnabled;
    });

    if (!_isEnabled) {
      showAlertDialog(context);
    }
  }

  void showAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Welcome, ${usernameController.text}'),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: TextField(
            enabled: _isEnabled,
            controller: usernameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Username'),
          ),
          margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 30.0),
        ),
        Container(
          child: TextField(
            enabled: _isEnabled,
            obscureText: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Password'),
          ),
          margin: const EdgeInsets.only(
              left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: TextButton(
            onPressed: buttonClicksEvent,
            child: _isEnabled ? const Text('Log in') : const Text('Waiting..'),
            style: TextButton.styleFrom(
              primary: Colors.black,
              minimumSize: const Size.fromHeight(50),
              textStyle: const TextStyle(
                fontSize: 20.0,
              ),
              backgroundColor: Colors.blue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: TextButton(
            onPressed: () {
              showAlertDialog(context);
            },
            child: const Text('Sign up'),
            style: TextButton.styleFrom(
              primary: Colors.white,
              minimumSize: const Size.fromHeight(50),
              textStyle: const TextStyle(
                fontSize: 20.0,
              ),
              backgroundColor: Colors.blue[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
