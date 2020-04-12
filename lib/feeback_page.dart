import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallsAndMessagesService {
  void call(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:$number");
  static void sendEmail(String email) => launch("mailto:$email");
}

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
            color: Colors.black54
        ),
        title: Text('Feedback', style: Theme.of(context).textTheme.headline2, ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: RichText(
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Write To Us', style: TextStyle(fontSize: 24.0, color: Colors.black, )),
                    TextSpan(text: '\n\nFor reporting a bug or suggesting a new feature or to just say hi!, you can write to us at', style: Theme.of(context).textTheme.headline3),
                    TextSpan(text: '\n\njain.ronak197@gmail.com', recognizer: TapGestureRecognizer()..onTap = (){ CallsAndMessagesService.sendEmail('jain.ronak197@gmail.com');}, style: TextStyle(color: Colors.blueAccent, fontFamily: 'Poppins', fontSize: 14.0))
                  ]
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: RichText(
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Contribute', style: TextStyle(fontSize: 24.0, color: Colors.black, )),
                    TextSpan(text: '\n\nFor all the developers out there this project is made open source on the Github. Feel free to report an issue and PRs are most Welcome!', style: Theme.of(context).textTheme.headline3),
                    TextSpan(text: '\n\nhttps://github.com/ronak197/pc-remote', recognizer: TapGestureRecognizer()..onTap = (){ launch('https://github.com/ronak197/pc-remote');}, style: TextStyle(color: Colors.blueAccent, fontFamily: 'Poppins', fontSize: 14.0))
                  ]
              ),
            ),
          )
        ],
      ),
    );
  }
}
