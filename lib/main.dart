import 'package:flutter/material.dart';
import 'Funcoes/global.dart';
import './login.dart';

/// TODO:
/// - handlers/validação dos inputFields <-
///   - inputfields da tela de Cadastro bugando
/// - historico de movimentações (?)
/// - outras telas
/// - backend
///   - nodejs (?)
///   - precisa comunicar com o arduino

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
      appBar: AppBar(
        title: const Text(
          'Smart Security',
          style: textStyleTitle,
        ),
        backgroundColor: Cores.bgAppBar,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Login(),
        ),
      ),
    );
  }
}
