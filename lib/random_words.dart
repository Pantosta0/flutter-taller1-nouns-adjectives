import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  String _Word = "0";
  int _actualWordType = 0;
  int _score = 0;
  bool _wrong = false;
  final _random = Random();

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    super.initState();
    setRandomWord();
  }

  void setRandomWord() {
    var option = next(0, 2);
    var randomItem = "";
    if (option == 0) {
      logInfo("change to noun");
      randomItem = (nouns.toList()..shuffle()).first;
    } else {
      logInfo("change to adjective");
      randomItem = (adjectives.toList()..shuffle()).first;
    }
    setState(() {
      _Word = randomItem;
      _actualWordType = option;
    });
  }

  void _onPressed(int type) {
    if (type == _actualWordType) {
      _score++;
      setState(() {});
    } else {
      _wrong = true;
      if (_score > 0) {
        _score--;
        setState(() {});
      }
      Future.delayed(const Duration(seconds: 2)).then((value) {
        setState(() {
          _wrong = false;
        });
      });
    }
    setRandomWord();
  }

  void _onReset(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text('Score reset :)')),
        duration: Duration(seconds: 3),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
    setState(() {
      _score = 0;
    });
    setRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Words"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Score = $_score",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                width: 15,
              )
            ],
          ),
          Text(_Word,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: MaterialButton(
                        onPressed:
                            _wrong == false ? () => _onPressed(0) : () {},
                        color: _wrong == false
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        child: const Text("Noun",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 30))),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: MaterialButton(
                        onPressed:
                            _wrong == false ? () => _onPressed(1) : () {},
                        color: _wrong == false
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        child: const Text("Adjective",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 30,
                                color: Colors.black))),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => _onReset(context),
                  color: Theme.of(context).primaryColor,
                  icon: Icon(Icons.refresh)),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
