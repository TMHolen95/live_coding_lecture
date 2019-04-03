import 'package:flutter/material.dart';
import 'package:live_coding_lecture/account_tile.dart';
import 'package:live_coding_lecture/bloc.dart';

class MyHomePageWithBloc extends StatefulWidget {
  MyHomePageWithBloc({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageWithBlocState createState() => _MyHomePageWithBlocState();
}

class _MyHomePageWithBlocState extends State<MyHomePageWithBloc> {
  DismissBloc bloc;
  DismissState state;


  @override
  void initState() {
    super.initState();
    bloc = DismissBloc();
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
          child: Text("${state.dismissedWidgetsLeft}"),
          radius: 10,
          backgroundColor: Colors.redAccent,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Dismissed right: "),
        ),
        CircleAvatar(
            child: Text("${state.dismissedWidgetsRight}"),
            radius: 10,
            backgroundColor: Colors.lightGreenAccent),
      ],
    );
  }

  Widget lastDismissed() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Last dismissed item: ${state.lastDismissedItem ?? "Null"}",
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget resetButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RaisedButton(
          onPressed: () => bloc.repopulateList(state),
          child: Text("Repopulate List"),
        ),
        RaisedButton(
          onPressed: () => bloc.resetCounters(state),
          child: Text("Reset Counters"),
        ),
      ],
    );
  }

  Widget dismissList() {
    return ListView.builder(
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];

        return Dismissible(
          key: Key(item),

          // Update the state as the tiles are dismissed
          onDismissed: (direction) => bloc.updateState(state, direction, index),

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
            child: StreamBuilder<DismissState>(
                stream: bloc.stream,
                initialData: bloc.initial(),
                builder: (context, snapshot) {
                  state = snapshot.data;

                  return Column(
                    children: <Widget>[
                      counters(),
                      lastDismissed(),
                      resetButtons(),
                      dismissList()
                    ],
                  );
                })));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
