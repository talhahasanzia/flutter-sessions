import 'package:flutter/material.dart';
import 'package:todoapp/database_helper.dart';
import 'package:todoapp/todo_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> _todoList = List<Todo>();
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _databaseHelper.queryAllRows().then((todoList) {
      if (todoList != null && todoList.isNotEmpty) {
        fetchData();
      }
    });
  }

  void addTodoItem(String title, String description) {
    _databaseHelper
        .insert(Todo(_todoList.length + 1, title, description))
        .then((id) {
      if (id != -1) {
        fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = getScaffold();
    return scaffold;
  }

  @override
  void dispose() {
    _databaseHelper.closeDatabase();
    super.dispose();
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

  void fetchData() {
    _databaseHelper.queryAllRows().then((todoList) {
      setState(() {
        _todoList = todoList;
      });
    });
  }

  List<Widget> getItems() {
    List<Widget> listTiles = new List();

    _todoList.forEach((element) {
      listTiles.add(
        Dismissible(
          background: Container(color: Colors.red),

          // Each Dismissible must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key(element.toString()),
          // Provide a function that tells the app
          // what to do after an item has been swiped away.
          onDismissed: (direction) {
            // Remove the item from the data source.
            _databaseHelper.delete(element.id).then((id) {
              fetchData();
            });
          },
          child: ListTile(
            title: Text(element.title),
            subtitle: Text(element.description),
          ),
        ),
      );
    });

    return listTiles;
  }
}

class MyFloatingActionButton extends StatelessWidget {
  final Function(String, String) _onAdded;
  String _cTitle = "";

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
                    decoration: InputDecoration(hintText: "Title"),
                    expands: false,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                    ),
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (text) {
                      _cTitle = text;
                    },
                    onChanged: (text) {
                      _cTitle = text;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Description"),
                    expands: false,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                    ),
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (text) {
                      _onAdded(_cTitle, text);
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
