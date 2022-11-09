// ignore_for_file: prefer_interpolation_to_compose_strings, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'Utils/global.dart';
import './Model/hist_mov_list.dart';

class HistoricoMov extends StatelessWidget {
  const HistoricoMov({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Histórico de Movimento',
          style: textStyleTitle,
        ),
        backgroundColor: Cores.bgAppBar,
        centerTitle: true,
      ),
      backgroundColor: Cores.bgTela,
      body: Center(
        child: Scrollbar(
          child: ListHistMov(),
        ),
      ),
    );
  }
}

class ListHistMov extends StatelessWidget {
  final List<HistMovList> movlist = getHistMovList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: movlist.length,
      itemBuilder: (context, index) {
        return Container(
          color: Cores.bgTela,
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            color: Color.fromARGB(255, 191, 190, 190),
            child: ListTile(
              title: Text(
                'Produto: ' +
                    movlist[index].label! +
                    '; Tipo: ' +
                    movlist[index].tipo!,
                textAlign: TextAlign.start,
                style: textStyleHistorico,
              ),
              subtitle: Text(
                'Data/Hora : ' +
                    movlist[index].data! +
                    '\n ' +
                    'Relatorio: ' +
                    movlist[index].desc! +
                    '\n',
                textAlign: TextAlign.start,
                style: textStyleHistorico,
              ),
            ),
          ),
        );
      },
    );
  }
}
