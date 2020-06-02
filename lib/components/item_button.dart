import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  final fontSize = 18.0;
  final Function press;
  final String text;

  const ItemButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Expanded(
      //use InkWell clear space between
      child: InkWell(
        child: OutlineButton(
          highlightedBorderColor: Colors.grey[400],
          padding: EdgeInsets.symmetric(vertical: 15.0),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
