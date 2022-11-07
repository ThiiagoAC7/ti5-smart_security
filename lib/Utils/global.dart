import 'package:flutter/material.dart';

const TextStyle textStyleTitle = TextStyle(
  fontSize: 20,
  letterSpacing: 3,
  color: Colors.white,
);

const TextStyle textStyleHistorico = TextStyle(
  fontSize: 15,
  letterSpacing: 2,
  color: Colors.black,
);

const TextStyle textStyleButton = TextStyle(
  fontSize: 15,
  letterSpacing: 3,
  color: Colors.white,
);

class Cores {
  static const bgTela = Color.fromARGB(255, 57, 53, 53);
  static const bgAppBar = Color.fromARGB(255, 27, 2, 128);
  static const bgLogin = Color.fromARGB(255, 149, 149, 149);
  static const bgTelaHome = Color.fromARGB(255, 255, 255, 255);
}

Widget buildButton(String label, Function()? func) {
  return ElevatedButton(
    onPressed: func,
    child: Text(
      label,
      style: textStyleButton,
    ),
  );
}

Widget sizedBoxButton(String label, Function()? func, double w, double h) {
  return SizedBox(
    width: w,
    height: h,
    child: buildButton(label, func),
  );
}

Widget buildTextField(
    String hint, TextEditingController ctrl, bool obscureText) {
  return TextFormField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white70,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      hintText: hint,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Informe um valor!';
      }
      return null;
    },
    controller: ctrl,
    obscureText: obscureText,
  );
}

PreferredSizeWidget mainAppBar() {
  return AppBar(
    title: const Text(
      'Smart Security',
      style: textStyleTitle,
    ),
    backgroundColor: Cores.bgAppBar,
    centerTitle: true,
  );
}
