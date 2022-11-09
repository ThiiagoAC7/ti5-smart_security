// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:smart_security/Utils/requisicoes.dart';
import 'package:smart_security/historico_movimentos.dart';
import 'Utils/global.dart';
import 'rfid.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      backgroundColor: Cores.bgTela,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: HomeBody(),
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Cores.bgTela,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: sizedBoxButton('Histórico de Movimentos', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoricoMov(),
                ),
              );
            }, 300, 30),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: sizedBoxButton('Configurar RFID', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Rfid(),
                ),
              );
            }, 300, 30),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: sizedBoxButton('Ativar Alarme', () async {
              var naosei = await activateAlarm(true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Status : $naosei',
                    style: TextStyle(
                      fontSize: 20,
                      color: naosei == 'enabled' ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              );
            }, 300, 30),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: sizedBoxButton('Desativar Alarme', () async {
              var naosei = await activateAlarm(false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Status : $naosei',
                    style: TextStyle(
                      fontSize: 20,
                      color: naosei == 'enabled' ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              );
            }, 300, 30),
          ),
        ],
      ),
    );
  }
}
