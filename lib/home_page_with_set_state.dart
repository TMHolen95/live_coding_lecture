import 'package:flutter/material.dart';
import 'package:live_coding_lecture/account_tile.dart';

class MyHomePageWithSetState extends StatefulWidget {
  MyHomePageWithSetState({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageWithSetStateState createState() => _MyHomePageWithSetStateState();
}

class _MyHomePageWithSetStateState extends State<MyHomePageWithSetState> {
  int dismissedWidgetsLeft = 0;
  int dismissedWidgetsRight = 0;
  int lastDismissedItem;

  List<String> items = List<String>.generate(10, (index) => "$index");

  void updateState(DismissDirection direction, int index) {
    setState(() {
      items.removeAt(index);
      if (direction == DismissDirection.startToEnd) {
        lastDismissedItem = index;
        dismissedWidgetsRight++;
      }
      else if (direction == DismissDirection.endToStart) {
        lastDismissedItem = index;
        dismissedWidgetsLeft++;
      }
    });
  }

  void repopulateList() {
    setState(() {
      items = List<String>.generate(10, (index) => "$index");
    });
  }

  void resetCounters() {
    setState(() {
      dismissedWidgetsLeft = 0;
      dismissedWidgetsRight = 0;
      lastDismissedItem = null;
    });
  }

  Widget counters() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Dismissed left: "),
        ),
        CircleAvatar(
          child: Text("$dismissedWidgetsLeft"),
          radius: 10,
          backgroundColor: Colors.redAccent,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Dismissed right: "),
        ),
        CircleAvatar(
            child: Text("$dismissedWidgetsRight"),
            radius: 10,
            backgroundColor: Colors.lightGreenAccent),
      ],
    );
  }

  Widget lastDismissed() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Last dismissed item: ${lastDismissedItem ?? "Null"}",
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget resetButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RaisedButton(
          onPressed: () => repopulateList(),
          child: Text("Repopulate List"),),
        RaisedButton(
          onPressed: () => resetCounters(),
          child: Text("Reset Counters"),),
      ],
    );
  }

  Widget dismissList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Dismissible(
          key: Key(item),

          // Update the state as the tiles are dismissed
          onDismissed: (direction) => updateState(direction, index),

          // Style the dismiss action.
          background: Container(color: Colors.lightGreenAccent),
          secondaryBackground: Container(color: Colors.redAccent),

          // Create the child tile.
          child: AccountTile(
            key: Key(index.toString()),
            index: index,
            name: "John Smith",
            url: "https://via.placeholder.com/50",
          ),
        );
      },
      primary: false,
      shrinkWrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                counters(),
                lastDismissed(),
                resetButtons(),
                dismissList()
              ],
            )));
  }
}
