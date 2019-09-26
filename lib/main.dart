import 'package:calculator/digit.dart';
import 'package:calculator/operation.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
              button: TextStyle(
                  fontSize: 25,
              ),
              body1: TextStyle(
                fontSize: 25,
              )
          )
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String text = '';
  List<String> numbers = new List();
  List<String> operations = new List();
  int point = 0;
  int op = 0;
  String selOp = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
            text,
            textAlign: TextAlign.right,

          ),
        ),
        ),
        Divider(
          height: 1,
          color: Colors.black45,
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        text = '';
                        point = 0;
                        op = 0;
                      });
                    },
                    child: Text('AC')

                ),
              ),
              VerticalDivider(
                width: 1,
                color: Colors.black45,
              ),
              Expanded(
                  child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if(text.length>0) {
                            if(text[text.length-1] == '.'){
                              point = 0;
                            }
                            text = text.substring(0, text.length-1);
                            if(text[text.length-1] == selOp){
                              op = 1;
                              point = 0;
                            }
                            else {
                              op = 0;
                            }
                          }
                        });
                      },
                      child: Icon(Icons.backspace)
                  )
              ),
              VerticalDivider(
                width: 1,
                color: Colors.black45,
              ),
              //Expanded(child: FlatButton(onPressed: () {}, child: Text('/'))),
              Operation(
                code: '/',
                onPress: _addOperation,
              ),
              VerticalDivider(
                width: 1,
                color: Colors.black45,
              ),
              //Expanded(child: FlatButton(onPressed: () {}, child: Text('x'))),
              Operation(
                code: 'x',
                onPress: _addOperation,
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Colors.black45,
        ),
        Expanded(
          flex: 1,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [7, 8, 9]
                      .expand<Widget>((n) => [
                            Digit(
                              number: '${n}',
                              onPress: _addDigit,
                            ),
                            VerticalDivider(
                              width: 1,
                              color: Colors.black45,
                            ),
                          ])
                      .toList() +
                  [
                    Operation(
                      code: '-',
                      onPress: _addOperation,
                    ),
                  ]),
        ),
        Divider(
          height: 1,
          color: Colors.black45,
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [4, 5, 6]
                .expand<Widget>((n) => [
              Digit(
                number: '${n}',
                onPress: _addDigit,
              ),
              VerticalDivider(
                width: 1,
                color: Colors.black45,
              ),
            ])
                .toList() +
                [
                  Operation(
                    code: '+',
                    onPress: _addOperation,
                  ),
                ]
          ),
        ),
        Divider(
          height: 1,
          color: Colors.black45,
        ),
        Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:
                              //[1,2,3].map((n) => Digit(number: '${n}', onPress: _addDigit,)).toList(),
                              [1, 2, 3]
                                  .expand((n) => [
                                        Digit(
                                          number: '${n}',
                                          onPress: _addDigit,
                                        ),
                                        VerticalDivider(
                                          width: 1,
                                          color: Colors.black45,
                                        ),
                                      ])
                                  .toList(),
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.black45,
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Digit(
                              number: '0',
                                flex: 2,
                                onPress: _addDigit,
                            ),
                            VerticalDivider(
                              width: 1,
                              color: Colors.black45,
                            ),
                            Expanded(child: FlatButton(onPressed:  _addPoint, child: Text('.'))),

                            VerticalDivider(
                              width: 1,
                              color: Colors.black45,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(child: FlatButton(onPressed:  _calculate, child: Text('='))),
              ],
            )),
      ],
    );
  }

  void _addDigit(String digit) {
    setState(() {
      op = 0;
      text = '${text}${digit}';
    });
  }

  void _addPoint(){
    setState(() {
      if (text == '' || text[text.length - 1] == selOp){
        text = '${text}0.';
        point = 1;
      }
      else {
        if (point == 0){
          text = '${text}.';
          point = 1;
        }
      }
    });
  }

  void _addOperation(String code){
    setState(() {
      if(text == '')
        text = '0';
      if(text[text.length-1]=='.')
        text = '${text}0';

      if(op == 0 || (code == '-' && (selOp == 'x' || selOp =='/')))
        text = '${text}${code}';
      else {
        text = text.substring(0, text.length - 1);
        if (text[text.length - 1] == 'x' || text[text.length - 1] == '/')
          text = text.substring(0, text.length - 1);
        text = '${text}${code}';
      }
      op = 1;
      point = 0;
      selOp = code;
    });
  }

  String _calculate2(String first, String second, String selOp){
    double a = double.parse(first);
    double b = double.parse(second);
    String rez = '';
    //setState(() {
      if(selOp == '/'){
        rez = (a / b).toString();
      }
      if(selOp == 'x'){
        rez = (a * b).toString();
      }
      if(selOp == '-'){
        rez = (a - b).toString();
      }
      if(selOp == '+'){
        rez = (a + b).toString();
      }
      return rez;
    //});
  }

  void _calculate() {
    int count = 0;
    String value = '';
    String ops = '+-x/';

    if (ops.indexOf(text[text.length - 1]) < 0) {
      //Add numbers and operations
      for (int i = 0; i < text.length; i++) {
        if (ops.indexOf(text[i]) >= 0 && ops.indexOf(text[i-1]) < 0) {
          numbers.add(value);
          operations.add(text[i]);
          value = '';
          count++;
        }
        else
          value = '${value}${text[i]}';
      }
      numbers.add(value);

      //Calculating
      while (count > 0) {
        if (count > 1 && ops.indexOf(operations[1]) > 1) {
          numbers[1] = _calculate2(numbers[1], numbers[2], operations[1]);
          numbers.removeAt(2);
          operations.removeAt(1);
        }
        else {
          numbers[0] = _calculate2(numbers[0], numbers[1], operations[0]);
          numbers.removeAt(1);
          operations.removeAt(0);
        }
        count--;
      }

      setState(() {
        text = numbers[0];
        numbers.clear();
        operations.clear();
        point = 0;
        op = 0;
        selOp = '';
      });
    }
  }
}
