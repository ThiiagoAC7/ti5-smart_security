// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:smart_security/home.dart';
import 'Utils/global.dart';
import './cadastro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final senhaController = TextEditingController();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.1,
        vertical: screenHeight * 0.2,
      ),
      decoration: BoxDecoration(
        color: Cores.bgLogin,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Form(
          key: formKey,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Login',
                  style: textStyleTitle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: buildTextField('email', emailController),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: buildTextField('senha', senhaController),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: sizedBoxButton(
                  'Entrar',
                  () async {
                    if (formKey.currentState!.validate()) {
                      var logado = await loginValidate(
                          emailController.text, senhaController.text);
                      if (logado) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Falha no Login',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                            backgroundColor: Colors.black54,
                          ),
                        );
                      }
                    }
                  },
                  315,
                  30,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: sizedBoxButton(
                  'Cadastrar',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cadastro(),
                      ),
                    );
                  },
                  315,
                  30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> loginValidate(userName, password) async {
    var client = http.Client();
    try {
      var url = Uri.http(API_URL, "/api/signin");
      var response = await client.post(
        url,
        body: jsonEncode({
          "user_name": userName,
          "password": password,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "7Sff-YcHdH_jDdWgPggv5Xe7LJ0",
        },
        encoding: Utf8Codec(),
      );
      if (response.statusCode == 201) {
        // debugPrint(response.body);
        Map login = jsonDecode(response.body);
        // debugPrint('-->> Response status: ${response.statusCode}');
        // debugPrint('-->> Response body: ${response.body}');
        // debugPrint('--->> Status : ${login['status']} ');
        // debugPrint('--->> Api Key: ${login['data']['api_key']} ');
        if (login['status'] == 'success') {
          return Future<bool>.value(true);
        }
      }
    } finally {
      client.close();
    }
    return Future<bool>.value(false);
  }
}
