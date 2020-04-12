import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:remote/feeback_page.dart';
import 'package:remote/help_page.dart';
import 'dart:io';

import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'dart:math' as math;

import 'package:remote/keyboard.dart';
import 'package:flutter/services.dart';
import 'package:remote/find_pc.dart';
import 'package:remote/connected_pc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

void main() async{
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          headline2: TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'Poppins', fontStyle: FontStyle.normal),
          headline3: TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: 'Poppins')
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Socket conn;
  double startPositionX = 0;
  double startPositionY = 0;

  String ip = "";

  bool getScreen = false;
  var imageData = List<int>();

  String imageFileName = 'imagebypc';
  var imageFilePath;

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    imageFilePath = await _localPath;
    return File('$imageFilePath/$imageFileName.png');
  }

  Future<File> writeData(String data) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(data);
  }

  void saveImage() async {
    if (imageData != null) {
      print('gone');
      String path = await _localPath;
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(imageData));
      print(result);
      if(result.toString().startsWith('file')){
        print('gone');
        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Image Saved ${result.toString()}', style: TextStyle(color: Colors.white),),duration: Duration(seconds: 2),));
      }
    }
  }

  void _sendMessage(String s) async {
    conn = await Socket.connect('$ip', 20001);
    conn.write(s);
    conn.close();
  }

  void getConnectedIp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ConnectedIp.ip = prefs.getString('pc_ip') ?? "";
    setState(() {
      ip = ConnectedIp.ip;
    });
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    getConnectedIp();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: true,
        drawer: FractionallySizedBox(
          widthFactor: 0.7,
          child: Drawer(
            elevation: 10.0,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text('PC-Remote', style: Theme.of(context).textTheme.headline2,),
                ),
                Container(
                  child: ConnectedIp.ip != "" ? Text('Configured to ${ConnectedIp.ip}', style: TextStyle(color: Colors.grey),) : SizedBox(),
                ),
                Divider(),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(Icons.help_outline, color: Colors.black, size: 22.0)
                      ),
                      Text('Help', style: Theme.of(context).textTheme.headline3,)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(Icons.feedback, color: Colors.black,)
                      ),
                      Text('Feedback', style: Theme.of(context).textTheme.headline3,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0.2,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
            color: Colors.black54
          ),
          title: Text('PC-Remote', style: Theme.of(context).textTheme.headline2, ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.computer,
                color: getScreen == false ? Colors.grey : Colors.black,
              ),
              onPressed: () {
                if(getScreen == false){
                  _sendMessage('getScreen');
                  conn.listen((onData) {
                    imageData = onData;
                  });
                  setState(() {
                    getScreen = true;
                  });
                } else {
                  setState(() {
                    getScreen = false;
                  });
                }

              },
            ),
            IconButton(
              icon: Icon(Icons.keyboard, color: Colors.black,),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KeyboardPage())),
            ),
            PopupMenuButton<String>(
              offset: Offset.fromDirection(math.pi/2,AppBar().preferredSize.height),
              onSelected: (String result) {
                if(result == 'Connect'){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FindPcPage())).then((value){
                    setState(() {});
                  });
                  getConnectedIp();
                }
                else if(result == 'Stop'){
                  _sendMessage('terminate');
                } else if(result == 'SaveImage'){
                  saveImage();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                getScreen != false ? const PopupMenuItem<String>(
                  value: 'SaveImage',
                  child: Text('Save Image'),
                ) : null,
                const PopupMenuItem<String>(
                  value: 'Connect',
                  child: Text('Find PC'),
                ),
                const PopupMenuItem<String>(
                  value: 'Stop',
                  child: Text('Stop PC Server'),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            getScreen != false ? Expanded(
              child: Container(
                height: 500.0,
                child: ClipRect(
                  child: PhotoView(
                    maxScale: PhotoViewComputedScale.covered * 2.0,
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    initialScale: PhotoViewComputedScale.contained,
                    imageProvider: MemoryImage(Uint8List.fromList(imageData)),
                  ),
                ),
              ),
            ) : SizedBox(),
            getScreen != true ? Container(
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0.0),
                        color: Colors.black,
                        child: Icon(
                            Icons.arrow_back
                        ),
                        onPressed: () => _sendMessage('left'),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0.0),
                        color: Colors.black,
                        child: Icon(
                            Icons.space_bar
                        ),
                        onPressed: () => _sendMessage('space'),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: CupertinoButton(
                        color: Colors.black,
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                            Icons.arrow_forward
                        ),
                        onPressed: () => _sendMessage('right'),
                      ),
                    ),
                  ),
                ],
              ),
            ) : SizedBox(),
            getScreen != true ? Flexible(
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: GestureDetector(
                      onTapUp: (d) {
                        _sendMessage("click");
                      },
                      onSecondaryTapDown: (d){
                        _sendMessage("rclick");
                      },
                      onVerticalDragUpdate: (d) {
                        _sendMessage("x:${(d.globalPosition.dx-startPositionX).toInt()},y:${(d.globalPosition.dy-startPositionY).toInt()};");
                      },
                      onVerticalDragStart: (d) {
                        startPositionX = d.globalPosition.dx;
                        startPositionY = d.globalPosition.dy;
                      },
                    ),
                  ),
                  Center(
                      child: Icon(Icons.mouse, size: 50.0, color: Colors.grey,)
                  )
                ],
              ),
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }
}