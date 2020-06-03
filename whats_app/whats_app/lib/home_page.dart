import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => {},
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.camera_alt)),
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FittedBox(
              fit: BoxFit.contain,
              child: Icon(Icons.camera_enhance),
            ),
            getChats(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle,
                      color: Colors.green,
                    ),
                    Text("Add your first status"),
                  ],
                )
              ],
            ),
            ListView(
              children: <Widget>[
                ListTile(
                  title: Text("John Doe"),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.blue,
                    ),
                  ),
                  trailing: Icon(
                    Icons.call_missed,
                    color: Colors.red,
                  ),
                ),
                ListTile(
                  title: Text("Jane Doe"),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.purple,
                    ),
                  ),
                  trailing: Icon(
                    Icons.call_missed,
                    color: Colors.red,
                  ),
                ),
                ListTile(
                  title: Text("Jeff Doe"),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.amber,
                    ),
                  ),
                  trailing: Icon(
                    Icons.call_made,
                    color: Colors.green,
                  ),
                ),
                ListTile(
                  title: Text("John Doe"),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.blue,
                    ),
                  ),
                  trailing: Icon(
                    Icons.call_received,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  getChats() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
            ),
          ),
          title: Text(
            "John Doe",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(
            "ttyl",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          trailing: Text(
            "09:34 pm",
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
            ),
          ),
          title: Text(
            "John Doe",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(
            "ttyl",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          trailing: Text(
            "09:34 pm",
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
            ),
          ),
          title: Text(
            "John Doe",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(
            "ttyl",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          trailing: Text(
            "09:34 pm",
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
            ),
          ),
          title: Text(
            "John Doe",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(
            "ttyl",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          trailing: Text(
            "09:34 pm",
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
            ),
          ),
          title: Text(
            "John Doe",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(
            "ttyl",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          trailing: Text(
            "09:34 pm",
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
            ),
          ),
          title: Text(
            "John Doe",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(
            "ttyl",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          trailing: Text(
            "09:34 pm",
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
            ),
          ),
          title: Text(
            "John Doe",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(
            "ttyl",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          trailing: Text(
            "09:34 pm",
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
            ),
          ),
          title: Text(
            "John Doe",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(
            "ttyl",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          trailing: Text(
            "09:34 pm",
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
            ),
          ),
          title: Text(
            "John Doe",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(
            "ttyl",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          trailing: Text(
            "09:34 pm",
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
            ),
          ),
          title: Text(
            "John Doe",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(
            "ttyl",
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          trailing: Text(
            "09:34 pm",
            style: TextStyle(color: Colors.green),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 25.0,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
            ),
          ),
          title: Text(
            "John Doe",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(
            "ttyl",
            style: TextStyle( 
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          trailing: Text(
            "09:34 pm",
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }
}
