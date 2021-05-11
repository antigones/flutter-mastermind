import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Game extends ChangeNotifier {
  List<int> _codeColours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<int> _answer = [];
  List<Widget> _guessList = [];
  String _message = "";

  String get message => _message;

  List<Widget> get guessList => _guessList;

  Game() {
    this.startGame();
  }

  List<int> _checkGuess(List<int> guess) {
    int matches = 0;
    int perms = 0;
    for (var i = 0; i < guess.length; i++) {
      for (var j = 0; j < guess.length; j++) {
        int g_i = guess[i];
        int a_j = _answer[j];
        if (g_i == a_j) {
          if (i == j)
            matches = matches + 1;
          else
            perms = perms + 1;
        }
      }
    }
    return [matches, perms];
  }

  bool _checkWin(matches) {
    return (matches == 4);
  }

  void addGuess(List<int> guess) {
    List<int> matches_perms = _checkGuess(guess);

    if (_checkWin(matches_perms[0])) {
      _message = "You won!";
    } else {
      _message = "Matches: " +
          matches_perms[0].toString() +
          "; Perms: " +
          matches_perms[1].toString();
    }
    _guessList.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(guess.toString() + " " + _message)],
    ));
    notifyListeners();
  }

  void _generateCode() {
    // generate a code without duplicates, to keep things easy
    _codeColours.shuffle();
    _answer.clear();
    _answer.addAll(_codeColours.take(4).toList());
    print(_answer);
  }

  void startGame() {
    _generateCode();
    _guessList.clear();
    notifyListeners();
  }
}
