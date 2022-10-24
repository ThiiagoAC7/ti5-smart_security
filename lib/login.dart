import 'package:flutter/material.dart';
import 'package:smart_security/home.dart';
import 'Funcoes/global.dart';
import './cadastro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _senhaController = TextEditingController();
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
          key: _formKey,
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
                child: buildTextField('email', _emailController),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: buildTextField('senha', _senhaController),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: sizedBoxButton(
                  'Entrar',
                  () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
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
}
