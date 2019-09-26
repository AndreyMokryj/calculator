import 'package:flutter/material.dart';

class Digit extends StatelessWidget{
  const Digit({this.number, this.onPress, this.flex=1});
  final String number;
  final ValueChanged<String> onPress;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FlatButton(onPressed: () {
        onPress(number);
      }, child: Text(number)),
    );
  }
}