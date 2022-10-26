import 'package:flutter/material.dart';
import 'Funcoes/global.dart';

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
                      child: buildTextField('email', emailControllerCad),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: buildTextField('senha', senhaControllerCad),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: sizedBoxButton('Cadastrar', () {
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Processando...'),
                            ),
                          );
                        }
                      }, 315, 30),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: sizedBoxButton('Login', () {
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Processando...'),
                            ),
                          );
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
