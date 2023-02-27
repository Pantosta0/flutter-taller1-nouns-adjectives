import 'package:f_template_juego_taller1/random_words.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  runApp(MaterialApp(
      theme: ThemeData(
          primarySwatch: MaterialColor(0xFF865DFF, <int, Color>{
        50: Color(0xFFEAEAFF),
        100: Color(0xFFC5B3FF),
        200: Color(0xFFA084FF),
        300: Color(0xFF7A55FF),
        400: Color(0xFF653BFF),
        500: Color(0xFF5121FF),
        600: Color(0xFF4A1DE6),
        700: Color(0xFF4018CC),
        800: Color(0xFF3613B2),
        900: Color(0xFF280A80),
      })),
      debugShowCheckedModeBanner: false,
      title: "RandomWords",
      home: RandomWords()));
}
