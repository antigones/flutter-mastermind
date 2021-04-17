import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(

        child: Form(
        key: _formKey,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<Game>(
              builder: (context, codeProvider, child) {
                return Text('${codeProvider.message}');
              },
            ),
            TextFormField(
              controller: myController,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Checking solution...')));
                  List<int> guess = myController.text.split(",").map((e) => int.parse(e)).toList();
                  Provider.of<Game>(context, listen: false).addGuess(guess);
                }
              },
              child: Text('Submit'),
            ),

          ],
        ),
      )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startNewGame(context),
        tooltip: 'Start New Game',
        child: Icon(Icons.loop),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
