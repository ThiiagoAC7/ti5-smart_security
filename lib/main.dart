import 'package:flutter/material.dart';
import 'Utils/global.dart';
import './login.dart';

/// TODO:
/// - historico de movimentações
/// - estuturar cominicação com backend
/// - validação logado/não logado
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
