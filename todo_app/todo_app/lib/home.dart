import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _todoList = List<String>();

  void addTodoItem(String todo) {
    setState(() {
      _todoList.add(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = getScaffold();
    return scaffold;
  }

  Scaffold getScaffold() {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (scaffoldContext) =>
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            ListView(
          children: getItems(),
        ),
      ),
      floatingActionButton: MyFloatingActionButton(
          addTodoItem), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> getItems() {
    List<Widget> listTiles = new List();

    _todoList.forEach((element) {
      listTiles.add(
        Dismissible(
          background: Container(color: Colors.red),

          // Each Dismissible must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key(element),
          // Provide a function that tells the app
          // what to do after an item has been swiped away.
          onDismissed: (direction) {
            // Remove the item from the data source.
            setState(() {
              _todoList.remove(element);
            });

            // Show a snackbar. This snackbar could also contain "Undo" actions.
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("$element dismissed")));
          },
          child: ListTile(title: Text('$element')),
        ),
      );
    });

    return listTiles;
  }
}

class MyFloatingActionButton extends StatelessWidget {
  final Function(String) _onAdded;

  MyFloatingActionButton(this._onAdded) : super();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showBottomSheet(
          context: context,
          builder: (context) => Container(
            height: 200,
            color: Colors.blueAccent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    expands: false,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                    ),
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (text) {
                      _onAdded(text);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
