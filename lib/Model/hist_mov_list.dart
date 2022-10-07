import 'package:flutter/material.dart';
// import '../Funcoes/global.dart';
import 'package:intl/intl.dart';

class HistMovList {
  int? id;
  String? tipo;
  String? label;
  String? data;
  String? desc;

  HistMovList({
    @required this.tipo,
    @required this.label,
    @required this.id,
    @required this.data,
    @required this.desc,
  });
}

List<HistMovList> histMovList = [];

List<HistMovList> getHistMovList() {
  DateFormat dFormat = DateFormat('dd-MM-yyyy HH:mm:ss');

  histMovList.add(
    HistMovList(
      tipo: 'Sensor',
      label: 'X',
      id: 0,
      data: dFormat.format(DateTime.now()),
      desc: 'Movimento suspeito detectado',
    ),
  );
  histMovList.add(
    HistMovList(
      tipo: 'Sensor',
      label: 'Y',
      id: 1,
      data: dFormat.format(DateTime.now()),
      desc: 'Objeto movimentado',
    ),
  );
  histMovList.add(
    HistMovList(
      tipo: 'Pessoa',
      label: 'Z',
      id: 2,
      data: dFormat.format(DateTime.now()),
      desc: 'Entrou no ambiente',
    ),
  );
  histMovList.add(
    HistMovList(
      tipo: 'Pessoa',
      label: 'W',
      id: 3,
      data: dFormat.format(DateTime.now()),
      desc: 'Saiu do Ambiente',
    ),
  );

  histMovList.add(
    HistMovList(
      tipo: 'Sensor',
      label: 'X',
      id: 0,
      data: dFormat.format(DateTime.now()),
      desc: 'Movimento suspeito detectado',
    ),
  );
  histMovList.add(
    HistMovList(
      tipo: 'Sensor',
      label: 'Y',
      id: 1,
      data: dFormat.format(DateTime.now()),
      desc: 'Objeto movimentado',
    ),
  );
  histMovList.add(
    HistMovList(
      tipo: 'Pessoa',
      label: 'Z',
      id: 2,
      data: dFormat.format(DateTime.now()),
      desc: 'Entrou no ambiente',
    ),
  );
  histMovList.add(
    HistMovList(
      tipo: 'Pessoa',
      label: 'W',
      id: 3,
      data: dFormat.format(DateTime.now()),
      desc: 'Saiu do Ambiente',
    ),
  );

  histMovList.add(
    HistMovList(
      tipo: 'Sensor',
      label: 'X',
      id: 0,
      data: dFormat.format(DateTime.now()),
      desc: 'Movimento suspeito detectado',
    ),
  );
  histMovList.add(
    HistMovList(
      tipo: 'Sensor',
      label: 'Y',
      id: 1,
      data: dFormat.format(DateTime.now()),
      desc: 'Objeto movimentado',
    ),
  );
  histMovList.add(
    HistMovList(
      tipo: 'Pessoa',
      label: 'Z',
      id: 2,
      data: dFormat.format(DateTime.now()),
      desc: 'Entrou no ambiente',
    ),
  );
  histMovList.add(
    HistMovList(
      tipo: 'Pessoa',
      label: 'W',
      id: 3,
      data: dFormat.format(DateTime.now()),
      desc: 'Saiu do Ambiente',
    ),
  );

  return histMovList;
}
