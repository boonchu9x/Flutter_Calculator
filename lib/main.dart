import 'package:calculatorapp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/item_button.dart';

void main() => runApp(MaterialApp(
      //don't show banner debug in screen
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ));

//use statefull widget to change state any view in widget
//when create statefull, can call function setState
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List lsString = Constant.lsStringButton;

  String output = '0';

  String _output = '0';

  double num_1 = 0.0;

  double num_2 = 0.0;

  String operand = '';

  int getPos(int pos) {
    print(pos);
    return pos;
  }

  void _actionOperand(int pos) {
    String txtPress = lsString[pos];
    if (txtPress == 'CLEAR') //button CLEAR
    {
      _output = '0';
      num_1 = 0.0;
      num_2 = 0.0;
      operand = '';
    } else if (txtPress == '.') {
      //already contains .
      if (_output.contains('.')) {
        print('Already contains a decimals');
        return;
      } else //not decimal
      {
        _output += txtPress;
      }
    } else if (txtPress == '+' ||
        txtPress == '-' ||
        txtPress == 'x' ||
        txtPress == '/') {
      num_1 = double.parse(output);
      operand = txtPress;
      _output = '0';
    } else if (txtPress == '=') {
      num_2 = double.parse(output);
      if (operand == '+') {
        _output = (num_1 + num_2).toString();
      }
      if (operand == '-') {
        _output = (num_1 - num_2).toString();
      }
      if (operand == 'x') {
        _output = (num_1 * num_2).toString();
      }
      if (operand == '/' && num_2 != 0.0) {
        _output = (num_1 / num_2).toString();
      }

      num_1 = 0.0;
      num_2 = 0.0;
      operand = '';
    } else {
      _output = txtPress;
    }
    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    //change status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.orange[400],
      //statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.orange[400],
      ),
      body: Column(
        children: <Widget>[
          Container(
            //alignment text center right
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 22.0),
            child: Text(
              output,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Row_Item(
            poStart: 0,
            poEnd: 3,
            //get callback
            getPositionCallBack: (int pos) => _actionOperand(pos),
          ),
          Row_Item(
            poStart: 4,
            poEnd: 7,
            getPositionCallBack: (int pos) => _actionOperand(pos),
          ),
          Row_Item(
            poStart: 8,
            poEnd: 11,
            getPositionCallBack: (int pos) => _actionOperand(pos),
          ),
          Row_Item(
            poStart: 12,
            poEnd: 15,
            getPositionCallBack: (int pos) => _actionOperand(pos),
          ),
          Row_Item(
            poStart: 16,
            poEnd: lsString.length - 1,
            getPositionCallBack: (int pos) => _actionOperand(pos),
          ),
        ],
      ),
    );
  }
}

class Row_Item extends StatelessWidget {
  final poStart;
  final poEnd;

  //call back
  final Function(int) getPositionCallBack;

  const Row_Item({
    Key key,
    this.poStart,
    this.poEnd,
    //parameter callback
    this.getPositionCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (var i = poStart; i <= poEnd; i++)
          ItemButton(
            text: Constant.lsStringButton[i].toString(),
            press: () => getPositionCallBack(i),
          )
      ],
    );
  }
}
