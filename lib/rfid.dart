// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'Utils/global.dart';
import 'package:smart_security/home.dart';
import 'Utils/requisicoes.dart';

@override
class Rfid extends StatefulWidget {
  const Rfid({super.key});

  @override
  State<Rfid> createState() => _RfidState();
}

class _RfidState extends State<Rfid> {
  @override
  Widget build(BuildContext context) {
    final insercaonome = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurar RFID',
          style: textStyleTitle,
        ),
        backgroundColor: Cores.bgAppBar,
        centerTitle: true,
      ),
      backgroundColor: Cores.bgTela,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Text(
                'Aproxime o RFID e então clique em configurar',
                style: textStyleTitle,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: buildTextField('Definir Nome', insercaonome, false),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: sizedBoxButton('Configurar', () async {
                  var naosei = await configureRfid(insercaonome.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Status : $naosei',
                        style: TextStyle(
                          fontSize: 20,
                          color: naosei == deubom ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  );
                }, 300, 30),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: sizedBoxButton('Voltar', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                }, 300, 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
