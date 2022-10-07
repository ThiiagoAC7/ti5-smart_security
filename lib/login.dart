import 'package:flutter/material.dart';
import 'package:smart_security/home.dart';
import 'Funcoes/global.dart';
import './cadastro.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Login',
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
              child: sizedBoxButton(
                'Entrar',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
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
    );
  }
}
