import 'package:flutter/material.dart';

class AccountTile extends StatelessWidget {
  final int index;
  final String name;
  final String url;

  const AccountTile(
      {Key key, this.name, this.url, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,4,0,4),
      child: Container(
          color: Color(0xffdddddd),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration:
                  BoxDecoration(color: Colors.black, border: Border.all()),
                  child: Image.network(url),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(child: Text(index.toString()),),
              )
            ],
          ),
        ),
      );
  }
}