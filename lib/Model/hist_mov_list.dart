import 'package:flutter/material.dart';
import '../Utils/requisicoes.dart';
import 'dart:developer' as dev;
import 'dart:convert';

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

parseHistMovList() async {
  if (histMovList == []) {
    dev.log("parseHistMovList - init");
    var jsonstring = await getActivityLog();

    for (var i in jsonstring) {
      fromJson(i);
    }
    dev.log("parseHistMovList - fim");
  }
}

List<HistMovList> getHistMovList() {
  parseHistMovList();
  return histMovList;
}

fromJson(Map m) {
  histMovList.add(
    HistMovList(
        tipo: m['type'],
        label: m['rfid_id'].toString(),
        id: m['id'],
        data: m['creation_date'],
        desc: m['log']),
  );
}
