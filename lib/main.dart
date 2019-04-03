import 'package:flutter/material.dart';
import 'package:live_coding_lecture/home_page_with_set_state.dart';
import 'package:live_coding_lecture/home_page_with_stream.dart';

// A revised example after a live coding session
// the 03.04.19 10:00-12:00 in C007

/// This starts the main flutter app
void main() => runApp(MyApp());

/// This is the main widget for the app
/// It returns a Material app with a title, theme, and home
///
/// In this example two different variants of a widget is passed to home.
///
/// The first is one using the bloc-pattern, an architectural pattern relying
/// on sinks and streams. This pattern cleanly separates buisness logic and the
/// presentation.
///
/// The second is a simpler variant using setState(), however this method mixes
/// the presentation with business logic.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePageWithBloc(title: 'Live Coding Tutorial'),
      //home: MyHomePageWithSetState(title: 'Live Coding Tutorial'),
    );
  }
}



