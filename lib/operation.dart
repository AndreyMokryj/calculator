import 'package:flutter/material.dart';

class Operation extends StatelessWidget{
  Operation({this.code, this.onPress, this.current = false});
  final String code;
  final ValueChanged<String> onPress;
   bool current;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(onPressed: () {
        onPress(code);
        current = true;
      },
          child: Text(code)
      ),
    );
  }

}