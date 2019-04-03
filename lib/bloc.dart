import 'dart:async';

import 'package:flutter/material.dart';

/// Manages the state for the Bloc
class DismissState{
    int dismissedWidgetsLeft = 0;
    int dismissedWidgetsRight = 0;
    int lastDismissedItem;
    List<String> items = List<String>.generate(10, (index) => "$index");
    DismissState();
}

/// An example of the Bloc architecture pattern.
class DismissBloc{


  StreamController<DismissState> dismissStateController = StreamController<DismissState>();

  /// By adding an updated state to this [Sink] a StreamBuilder listening to
  /// the stream will refresh every time a new state is received.
  Sink get updateDismissState => dismissStateController.sink;

  /// Listen to this in a StreamBuilder
  Stream<DismissState> get stream => dismissStateController.stream;

  DismissBloc();

  /// Create the first state (initialData) for the StreamBuilder.
  DismissState initial(){
    return DismissState();
  }

  void dispose(){
    dismissStateController.close();
  }

  /// Convenience method for sending a new state to the sink.
  void _update(DismissState state){
    updateDismissState.add(state);
  }


  void updateState(DismissState state, DismissDirection direction, int index) {
      state.items.removeAt(index);
      if (direction == DismissDirection.startToEnd) {
        state.lastDismissedItem = index;
        state.dismissedWidgetsRight++;
      }
      else if (direction == DismissDirection.endToStart) {
        state.lastDismissedItem = index;
        state.dismissedWidgetsLeft++;
      }
      _update(state);
  }

  void repopulateList(DismissState state) {
      state.items = List<String>.generate(10, (index) => "$index");
      _update(state);
  }

  void resetCounters(DismissState state) {
      state.dismissedWidgetsLeft = 0;
      state.dismissedWidgetsRight = 0;
      state.lastDismissedItem = null;
      _update(state);
  }




}