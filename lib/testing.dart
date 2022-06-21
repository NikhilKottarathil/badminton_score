import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Auto Complete TextField Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FirstPage(),
    );
  }
}




class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => new _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  _FirstPageState() {
    textField = SimpleAutoCompleteTextField(
      key: key,
      decoration: new InputDecoration(errorText: "Beans"),
      controller: TextEditingController(text: "Starting Text"),
      suggestions: suggestions,
      textChanged: (text) => currentText = text,
      clearOnSubmit: true,
      textSubmitted: (text) => setState(() {
        if (text != "") {
          added.add(text);
        }
      }),
    );
  }

  List<String> suggestions = [
    "Apple",
    "Armidillo",
    "Actual",
    "Actuary",
    "America",
    "Argentina",
    "Australia",
    "Antarctica",
    "Blueberry",
    "Cheese",
    "Danish",
    "Eclair",
    "Fudge",
    "Granola",
    "Hazelnut",
    "Ice Cream",
    "Jely",
    "Kiwi Fruit",
    "Lamb",
    "Macadamia",
    "Nachos",
    "Oatmeal",
    "Palm Oil",
    "Quail",
    "Rabbit",
    "Salad",
    "T-Bone Steak",
    "Urid Dal",
    "Vanilla",
    "Waffles",
    "Yam",
    "Zest"
  ];

  SimpleAutoCompleteTextField textField;
  bool showWhichErrorText = false;

  @override
  Widget build(BuildContext context) {
    Column body = new Column(children: [
      new ListTile(
          title: textField,
          trailing: new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () {
                textField.triggerSubmitted();
                showWhichErrorText = !showWhichErrorText;
                textField.updateDecoration(
                    decoration: new InputDecoration(
                        errorText: showWhichErrorText ? "Beans" : "Tomatoes"));
              })),
    ]);

    body.children.addAll(added.map((item) {
      return new ListTile(title: new Text(item));
    }));

    return new Scaffold(
        appBar: new AppBar(
            title: new Text('AutoComplete TextField Demo Simple'),
            actions: [
              new IconButton(
                  icon: new Icon(Icons.edit),
                  onPressed: () => showDialog(
                      builder: (_) {
                        String text = "";

                        return new AlertDialog(
                            title: new Text("Change Suggestions"),
                            content: new TextField(
                                onChanged: (newText) => text = newText),
                            actions: [
                              new FlatButton(
                                  onPressed: () {
                                    if (text != "") {
                                      suggestions.add(text);
                                      textField.updateSuggestions(suggestions);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: new Text("Add")),
                            ]);
                      },
                      context: context))
            ]),
        body: body);
  }
}


