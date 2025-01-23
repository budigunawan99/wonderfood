import 'package:flutter/material.dart';

enum WonderfoodColors {
  orange("Orange", Color(0xFFca5116)),
  lightOrange("Light Orange", Color(0xFFf1e3cb)),
  brown("Brown", Color(0xFF581c0c)),
  darkBlue("Dark Blue", Color.fromARGB(255, 1, 18, 47)),
  lightBlue("Light Blue", Color.fromARGB(255, 36, 73, 135)),
  neutralBlue("Neutral Blue", Color.fromARGB(255, 16, 45, 95)),
  red("Red", Colors.redAccent),
  white("White", Colors.white),
  black("Black", Colors.black);

  const WonderfoodColors(this.name, this.color);

  final String name;
  final Color color;
}
