// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:smart_security/home.dart';
import 'Utils/global.dart';
import './cadastro.dart';
import 'Utils/requisicoes.dart';

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
                child: buildTextField('usuario', emailController, false),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: buildTextField('senha', senhaController, true),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: sizedBoxButton(
                  'Entrar',
                  () async {
                    if (formKey.currentState!.validate()) {
                      var logado = await loginValidate(
                          emailController.text, senhaController.text);
                      if (logado == deubom) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Falha no Login $logado',
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
}
