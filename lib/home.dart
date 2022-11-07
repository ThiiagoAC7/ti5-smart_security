import 'package:flutter/material.dart';
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
          Container(
            color: Colors.black,
            margin: EdgeInsets.only(top: 20),
            width: 300,
            height: 200,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 150),
            child: Text(
              'Cameras: 1 2 3 ',
              style: textStyleTitle,
            ),
          ),
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
            child: sizedBoxButton('Ativar Alarme', () {}, 300, 30),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: sizedBoxButton('Desativar Alarme', () {}, 300, 30),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: sizedBoxButton('Adicionar Camera', () {}, 300, 30),
          ),
        ],
      ),
    );
  }
}
