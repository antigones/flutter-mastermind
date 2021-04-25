import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color_form_field.dart';
import 'game.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Game()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
  String _title = "Mastermind";
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  void startNewGame(BuildContext context) {
    Provider.of<Game>(context, listen: false).startGame();
  }

  @override
  Widget build(BuildContext context) {
    List<int> _guess = [-1,-1,-1,-1];

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(

        child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<Game>(
              builder: (context, codeProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: codeProvider.guessList,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ColorFormField(onSaved: (value) {
              _guess[0] = value;
            },),
              ColorFormField(onSaved: (value) {
                _guess[1] = value;
              }),
              ColorFormField(onSaved: (value) {
                _guess[2] = value;
              }),
              ColorFormField(onSaved: (value) {
                _guess[3] = value;
              }),],),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  Set checkSet = Set.from(_guess);
                  if (checkSet.length == _guess.length) {
                    // no duplicates
                    Provider.of<Game>(context, listen: false).addGuess(_guess);
                  }
                  else
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('The solution cannot contain duplicates')));
                  //List<int> guess = myController.text.split(",").map((e) => int.parse(e)).toList();

                }
              },
              child: Text('Check'),
            ),
          ],
        ),
      )
      ),

    );
  }
}
