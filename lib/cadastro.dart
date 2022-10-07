import 'package:flutter/material.dart';
import 'Funcoes/global.dart';

class Cadastro extends StatelessWidget {
  const Cadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.bgTela,
      appBar: AppBar(
        title: const Text(
          'Smart Security',
          style: textStyleTitle,
        ),
        backgroundColor: Cores.bgAppBar,
        centerTitle: true,
      ),
      body: Center(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 150, vertical: 300),
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
                child: buildTextField('email'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: buildTextField('senha'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: sizedBoxButton('Cadastrar', () {}, 315, 30),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: sizedBoxButton('Login', () {}, 315, 30),
              )
            ],
          ),
        ),
      )),
    );
  }
}
