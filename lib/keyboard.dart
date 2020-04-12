import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:remote/connected_pc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyboardPage extends StatefulWidget {
  @override
  _KeyboardPageState createState() => _KeyboardPageState();
}



class _KeyboardPageState extends State<KeyboardPage> {

  TextEditingController textEditingController;
  String ip;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight,DeviceOrientation.landscapeLeft]);
    super.initState();
  }

  @override
  void dispose(){
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            row1(),
            row2(),
            row3(),
            row4(this), // To change keyboard state with alternative key names
            row5(),
            row6()
          ],
        ),
      ),
    );
  }
}

Row row1(){
  return Row(
    children: <Widget>[
      ButtonKey(keyName: 'Esc', alterKeyName: 'Esc', givenFlex: 1,),
      ButtonKey(keyName: 'F1', alterKeyName: 'F1', givenFlex: 1,),
      ButtonKey(keyName: 'F2', alterKeyName: 'F2', givenFlex: 1,),
      ButtonKey(keyName: 'F3', alterKeyName: 'F3', givenFlex: 1,),
      ButtonKey(keyName: 'F4', alterKeyName: 'F4', givenFlex: 1,),
      ButtonKey(keyName: 'F5', alterKeyName: 'F5', givenFlex: 1,),
      ButtonKey(keyName: 'F6', alterKeyName: 'F6', givenFlex: 1,),
      ButtonKey(keyName: 'F7', alterKeyName: 'F7', givenFlex: 1,),
      ButtonKey(keyName: 'F8', alterKeyName: 'F8', givenFlex: 1,),
      ButtonKey(keyName: 'F9', alterKeyName: 'F9', givenFlex: 1,),
      ButtonKey(keyName: 'F10', alterKeyName: 'F10', givenFlex: 1,),
      ButtonKey(keyName: 'F11', alterKeyName: 'F11', givenFlex: 1,),
      ButtonKey(keyName: 'F12', alterKeyName: 'F12', givenFlex: 1,),
      ButtonKey(keyName: 'PrtScr', alterKeyName: 'PrtScr', givenFlex: 1,),
      ButtonKey(keyName: 'Insert', alterKeyName: 'Insert', givenFlex: 1, ),
      ButtonKey(keyName: 'Delete', alterKeyName: 'Delete', givenFlex: 1,),
    ],
  );
}

Row row2(){
  return Row(
    children: <Widget>[
      ButtonKey(keyName: '`', alterKeyName: '~', givenFlex: 1,),
      ButtonKey(keyName: '1', alterKeyName: '!', givenFlex: 1,),
      ButtonKey(keyName: '2', alterKeyName: '@', givenFlex: 1,),
      ButtonKey(keyName: '3', alterKeyName: '#', givenFlex: 1,),
      ButtonKey(keyName: '4', alterKeyName: '\$', givenFlex: 1,),
      ButtonKey(keyName: '5', alterKeyName: '%', givenFlex: 1,),
      ButtonKey(keyName: '6', alterKeyName: '^', givenFlex: 1,),
      ButtonKey(keyName: '7', alterKeyName: '&', givenFlex: 1,),
      ButtonKey(keyName: '8', alterKeyName: '*', givenFlex: 1,),
      ButtonKey(keyName: '9', alterKeyName: '(', givenFlex: 1,),
      ButtonKey(keyName: '0', alterKeyName: ')', givenFlex: 1,),
      ButtonKey(keyName: '-', alterKeyName: '_', givenFlex: 1,),
      ButtonKey(keyName: '=', alterKeyName: '+', givenFlex: 1,),
      ButtonKey(keyName: '', alterKeyName: 'backspace', givenFlex: 2, givenIcon: Icon(Icons.backspace),),
    ],
  );
}

Row row3(){
  return Row(
    children: <Widget>[
      ButtonKey(keyName: 'Tab', alterKeyName: 'Tab', givenFlex: 2,),
      ButtonKey(keyName: 'Q', alterKeyName: 'q', givenFlex: 1,),
      ButtonKey(keyName: 'W', alterKeyName: 'w', givenFlex: 1,),
      ButtonKey(keyName: 'E', alterKeyName: 'e', givenFlex: 1,),
      ButtonKey(keyName: 'R', alterKeyName: 'r', givenFlex: 1,),
      ButtonKey(keyName: 'T', alterKeyName: 't', givenFlex: 1,),
      ButtonKey(keyName: 'Y', alterKeyName: 'y', givenFlex: 1,),
      ButtonKey(keyName: 'U', alterKeyName: 'u', givenFlex: 1,),
      ButtonKey(keyName: 'I', alterKeyName: 'i', givenFlex: 1,),
      ButtonKey(keyName: 'O', alterKeyName: 'o', givenFlex: 1,),
      ButtonKey(keyName: 'P', alterKeyName: 'p', givenFlex: 1,),
      ButtonKey(keyName: '[', alterKeyName: '{', givenFlex: 1,),
      ButtonKey(keyName: ']', alterKeyName: '}', givenFlex: 1,),
    ],
  );
}

Row row4(_KeyboardPageState keyboardState) {
  return Row(
    children: <Widget>[
      ButtonKey(keyName: '', alterKeyName: 'Alts', givenFlex: 2, givenIcon: Icon(Icons.arrow_upward), keyboardPageState: keyboardState,),
      ButtonKey(keyName: 'A', alterKeyName: 'a', givenFlex: 1,),
      ButtonKey(keyName: 'S', alterKeyName: 's', givenFlex: 1,),
      ButtonKey(keyName: 'D', alterKeyName: 'd', givenFlex: 1,),
      ButtonKey(keyName: 'F', alterKeyName: 'f', givenFlex: 1,),
      ButtonKey(keyName: 'G', alterKeyName: 'g', givenFlex: 1,),
      ButtonKey(keyName: 'H', alterKeyName: 'h', givenFlex: 1,),
      ButtonKey(keyName: 'J', alterKeyName: 'j', givenFlex: 1,),
      ButtonKey(keyName: 'K', alterKeyName: 'k', givenFlex: 1,),
      ButtonKey(keyName: 'L', alterKeyName: 'l', givenFlex: 1,),
      ButtonKey(keyName: '\;', alterKeyName: ':', givenFlex: 1,),
      ButtonKey(keyName: '\'', alterKeyName: '\"', givenFlex: 1,),
      ButtonKey(keyName: 'Enter', alterKeyName: 'Enter', givenFlex: 2,),
    ],
  );
}

Row row5(){
  return Row(
    children: <Widget>[
      ButtonKey(keyName: 'Shift', alterKeyName: 'Shift', givenFlex: 2,),
      ButtonKey(keyName: 'Z', alterKeyName: 'z', givenFlex: 1,),
      ButtonKey(keyName: 'X', alterKeyName: 'x', givenFlex: 1,),
      ButtonKey(keyName: 'C', alterKeyName: 'c', givenFlex: 1,),
      ButtonKey(keyName: 'V', alterKeyName: 'v', givenFlex: 1,),
      ButtonKey(keyName: 'B', alterKeyName: 'b', givenFlex: 1,),
      ButtonKey(keyName: 'N', alterKeyName: 'n', givenFlex: 1,),
      ButtonKey(keyName: 'M', alterKeyName: 'm', givenFlex: 1,),
      ButtonKey(keyName: ',', alterKeyName: '<', givenFlex: 1,),
      ButtonKey(keyName: '.', alterKeyName: '>', givenFlex: 1,),
      ButtonKey(keyName: '/', alterKeyName: '?', givenFlex: 1,),
      ButtonKey(keyName: 'Shift', alterKeyName: 'Shift', givenFlex: 2,),
    ],
  );
}

Row row6(){
  return Row(
    children: <Widget>[
      ButtonKey(keyName: 'Ctrl', alterKeyName: 'Ctrl', givenFlex: 2,),
      ButtonKey(keyName: 'Fn', alterKeyName: 'Fn', givenFlex: 1,),
      ButtonKey(keyName: '', alterKeyName: 'win', givenFlex: 1, givenIcon: Icon(Icons.menu, color: Colors.white,),),
      ButtonKey(keyName: 'Alt', alterKeyName: 'Alt', givenFlex: 1,),
      ButtonKey(keyName: '', alterKeyName: '', givenFlex: 4,),
      ButtonKey(keyName: 'Alt', alterKeyName: 'Alt', givenFlex: 1,),
      ButtonKey(keyName: 'Ctrl', alterKeyName: 'Ctrl', givenFlex: 1,),
      ButtonKey(keyName: '', alterKeyName: 'left', givenFlex: 1, givenIcon: Icon(Icons.arrow_back, color: Colors.white,),),
      Container(
        height: 80.0,
        padding: EdgeInsets.all(0.0),
        child: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: Axis.vertical,
          children: <Widget>[
            ButtonKey(keyName: '', alterKeyName: 'up', givenFlex: 1, givenIcon: Icon(Icons.arrow_upward),),
            ButtonKey(keyName: '', alterKeyName: 'down', givenFlex: 1, givenIcon: Icon(Icons.arrow_downward),),
          ],
        ),
      ),
      ButtonKey(keyName: '', alterKeyName: 'right', givenFlex: 1, givenIcon: Icon(Icons.arrow_forward, color: Colors.white,),),
    ],
  );
}


class ButtonKey extends StatefulWidget {

  final String keyName;
  final String alterKeyName;
  final int givenFlex;
  final Icon givenIcon;
  _KeyboardPageState keyboardPageState;

  ButtonKey({this.keyName,this.alterKeyName,this.givenFlex, this.givenIcon,this.keyboardPageState});

  @override
  _ButtonKeyState createState() => _ButtonKeyState();
}

bool showAlt = false;

class _ButtonKeyState extends State<ButtonKey> {
  Socket channel;

  void _sendMessage(String givenName) async {
    String s;
    if(widget.keyName == "") {
      s = widget.alterKeyName;
    } else {
      s = givenName;
    }
    channel = await Socket.connect('${ConnectedIp.ip}', 12345);
    channel.write(s);
    channel.close();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: widget.givenFlex,
      fit: FlexFit.tight,
      child: Container(
        padding: EdgeInsets.all(2.0),
        child: CupertinoButton(
          borderRadius: BorderRadius.circular(4.0),
          padding: EdgeInsets.all(0.0),
          onPressed: () {
            if(widget.alterKeyName == 'Alts'){
              widget.keyboardPageState.setState(() {
                if(showAlt == false){
                  showAlt = true;
                } else {
                  showAlt = false;
                }
              });
            } else {
              _sendMessage(showAlt != true ? widget.keyName : widget.alterKeyName);
            }

          },
          child: widget.keyName != '' ? Text(showAlt != true ? widget.keyName : widget.alterKeyName, style: TextStyle(color: Colors.white, fontSize: 13.0),) : Container(child: widget.givenIcon),
          color: Colors.black,
        ),
      ),
    );
  }
}

