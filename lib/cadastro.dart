// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'Utils/global.dart';
import 'Utils/requisicoes.dart';
import 'home.dart';
import 'dart:developer' as dev;

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  static final formKey = GlobalKey<FormState>();
  final emailControllerCad = TextEditingController();
  final senhaControllerCad = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Cores.bgTela,
      appBar: mainAppBar(),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
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
                        'Cadastrar',
                        style: textStyleTitle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child:
                          buildTextField('usuario', emailControllerCad, false),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: buildTextField('senha', senhaControllerCad, true),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: sizedBoxButton('Cadastrar', () async {
                        if (formKey.currentState!.validate()) {
                          var registrado = await registerValidate(
                              emailControllerCad.text, senhaControllerCad.text);
                          dev.log("Cadastrar", error: registrado);
                          if (registrado == deubom) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Registrado com sucesso!',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                  ),
                                ),
                                backgroundColor: Colors.black54,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Falha ao Registrar: $registrado',
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
                      }, 315, 30),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: sizedBoxButton('Login', () async {
                        if (formKey.currentState!.validate()) {
                          var logado = await loginValidate(
                              emailControllerCad.text, senhaControllerCad.text);
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
                      }, 315, 30),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
