import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {

  String link = "https://github.com/ronak197/pc-remote/pc-remote-server.exe";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
            color: Colors.black54
        ),
        title: Text('Help', style: Theme.of(context).textTheme.headline2, ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Connect to PC', style: TextStyle(fontSize: 24.0, color: Colors.black, )),
                    TextSpan(text: '\n\nDownload the pc-remote-server.exe file on your pc from this link', style: Theme.of(context).textTheme.headline3),
                    TextSpan(text: '\n\n$link', style: TextStyle(color: Colors.blueAccent, fontFamily: 'Poppins', fontSize: 14.0), recognizer: TapGestureRecognizer()..onTap = (){ launch(link);}),
                    TextSpan(text: '\n\nTo able to use your mobile as pc-remote you need to be on same wifi connection your pc is connected', style: Theme.of(context).textTheme.headline3),
                    TextSpan(text: '\n\nStep 1: Run the pc-remote-server.exe file on your pc', style: Theme.of(context).textTheme.headline3),
                    TextSpan(text: '\n\nStep 2: Make sure both your mobile and pc are on same Wifi connection', style: Theme.of(context).textTheme.headline3),
                    TextSpan(text: '\n\nStep 3: Select the "Find PC" option from pop-up-menu on the homepage"', style: Theme.of(context).textTheme.headline3),
                    TextSpan(text: '\n\nStep 4: Select the PC IPv4 address, you want to connect with from the displaced available PCs', style: Theme.of(context).textTheme.headline3),
                    TextSpan(text: '\n\nStep 5: Now your device is configured for that IP and is ready to use.', style: Theme.of(context).textTheme.headline3)
                  ]
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Disconnect PC Server', style: TextStyle(fontSize: 24.0, color: Colors.black, )),
                      TextSpan(text: '\n\nTo stop the server running on PC, you can click the option "Stop PC Server" from pop-up-menu.', style: Theme.of(context).textTheme.headline3),
                    ]
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Recieve PC Screenshot', style: TextStyle(fontSize: 24.0, color: Colors.black, )),
                      TextSpan(text: '\n\nStep 1: Make sure both your mobile and pc are on same Wifi connection', style: Theme.of(context).textTheme.headline3),
                      TextSpan(text: '\n\nStep 2: Toggle click the computer screen icon on the app bar of the homepage tp get the PC screenshot.', style: Theme.of(context).textTheme.headline3),
                      TextSpan(text: '\n\nStep 3: Save the screenshot by clicking on "Save Image" option in pop-menu', style: Theme.of(context).textTheme.headline3)
                    ]
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Use Keyboard Functions', style: TextStyle(fontSize: 24.0, color: Colors.black, )),
                      TextSpan(text: '\n\nYou can use the keyboard option on the app bar of the homepage to display keyboard keys.', style: Theme.of(context).textTheme.headline3),
                      TextSpan(text: '\n\nClick buttons to send the key pressed to the PC.', style: Theme.of(context).textTheme.headline3),
                    ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
