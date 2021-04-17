import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Settings extends ChangeNotifier {

  int _nOfColors = 4;
  int get nOfColors => _nOfColors;

}