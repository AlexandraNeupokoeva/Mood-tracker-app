import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                Page1(),
                Page2(),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String displayText = '';
  String displayText1 = '';
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      // Retrieve stored values
      displayText = _prefs.getString('displayText') ?? '';
      displayText1 = _prefs.getString('displayText1') ?? '';
    });
  }

  void _savePrefs() {
    _prefs.setString('displayText', displayText);
    _prefs.setString('displayText1', displayText1);
  }

  @override
  Widget build(BuildContext context) {
    // ... existing build method

    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(
            color: Colors.tealAccent[100],
            height: 200,
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.sentiment_dissatisfied_outlined),
                      onPressed: () {
                        setState(() {
                          displayText = 'Плохое';
                          _savePrefs();
                        });
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          displayText = 'Нормальное';
                          _savePrefs();
                        });
                      },
                      icon: Icon(Icons.sentiment_dissatisfied),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          displayText = 'Хорошое';
                          _savePrefs();
                        });
                      },
                      icon: Icon(Icons.sentiment_satisfied_alt),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  displayText,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 50,),
          Container(
            color: Colors.tealAccent[100],
            height: 400,
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.cloudy_snowing),
                      onPressed: () {
                        setState(() {
                          displayText1 = 'Снег';
                          _savePrefs();
                        });
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          displayText1 = 'Облачно';
                          _savePrefs();
                        });
                      },
                      icon: Icon(Icons.cloud),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          displayText1 = 'Солнечно';
                          _savePrefs();
                        });
                      },
                      icon: Icon(Icons.sunny),
                    ),
                    IconButton(
                      icon: Icon(Icons.cloudy_snowing),
                      onPressed: () {
                        setState(() {
                          displayText1 = 'Дождь';
                          _savePrefs();
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      displayText1,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final List<String> _text = [];
  final _textController = TextEditingController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _text.addAll(_prefs.getStringList('textList') ?? []);
    });
  }

  void _savePrefs() {
    _prefs.setStringList('textList', _text);
  }

  void _addText() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _text.add(_textController.text);
        _textController.clear();
        _savePrefs();
      });
    }
  }

  void _deleteText(int index) {
    setState(() {
      _text.removeAt(index);
      _savePrefs();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Сегодняшние дела'),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                color: Colors.tealAccent[100],
                width: 600,
                height: screenHeight * 0.8, // Adjust the percentage as needed
                margin: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          hintText: 'Введите текст',
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _text.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_text[index]),
                            trailing: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _deleteText(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: FloatingActionButton(
                        onPressed: _addText,
                        tooltip: 'Добавить запись',
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
