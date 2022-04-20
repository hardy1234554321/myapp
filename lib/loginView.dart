import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isEnabled = true;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final url = 'https://myapi-auth.herokuapp.com/api/post/auth';

  Future<void> singinEvent() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEnabled = !_isEnabled;
      });

      if (!_isEnabled) {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
          body: jsonEncode({
            'username': _usernameController.text,
            'password': _passwordController.text
          }),
        );

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);

          //顯示下方提示訊息
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '${_usernameController.text}, login ${responseData['status']}!'),
            ),
          );
        } else {
          throw Exception('Failed to auth.');
        }
      }
    }
  }

  void singupEvent() {
    //顯示跳出視窗
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Welcome, ${_usernameController.text}'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    enabled: _isEnabled,
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    enabled: _isEnabled,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: singinEvent,
                    child: _isEnabled
                        ? const Text('Sign in')
                        : const Text('Waiting..'),
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: const Size.fromHeight(50),
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                      ),
                      backgroundColor: Colors.blue[50],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: singupEvent,
                    child: const Text('Sign up'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                      ),
                      backgroundColor: Colors.blue[300],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
