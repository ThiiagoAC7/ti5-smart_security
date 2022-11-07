import 'package:flutter/material.dart';
import 'Utils/global.dart';
import './login.dart';

/// TODO:
/// - historico de movimentações
///   - botao -> GET no banco de dados
///              tabela activity_log
/// - configurar RFID ->
///   POST -> mandar a tag_rfid (rfid),
///                    nome_objeto (objeto)
/// -

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Smart Security';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.bgTela,
      appBar: mainAppBar(),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Login(),
        ),
      ),
    );
  }
}
