import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:wifi/wifi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:remote/connected_pc.dart';

class FindPcPage extends StatefulWidget {
  @override
  _FindPcPageState createState() => _FindPcPageState();
}

class _FindPcPageState extends State<FindPcPage> {

  List<NetworkDevice> availablePCs = List();
  String connectedIp = "";

  void setIp(String ip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pc_ip', ip);
    ConnectedIp.ip = ip;
  }

  void getConnectedIp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    connectedIp = prefs.getString('pc_ip') ?? "";
    setState(() {

    });
  }

  void getAvailablePc() async {
    final String ip = await Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = 80;

    final stream = NetworkAnalyzer.discover2(subnet, port);
//    List<dynamic> address = await NetworkInterface.list(includeLinkLocal: true, includeLoopback: true, type: InternetAddressType.IPv4);
//    print(address);
    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        setState(() {
          availablePCs.add(NetworkDevice(ip: addr.ip));
        });
      }
    });
  }

  @override
  void initState() {
    getConnectedIp();
    getAvailablePc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
            color: Colors.black54
        ),
        title: Text('Available PC', style: Theme.of(context).textTheme.headline2, ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: availablePCs.length,
        itemBuilder: (context, index){
          String ip = availablePCs[index].ip;
          return ListTile(
            title: Text(ip),
            trailing: connectedIp != ip ? RawMaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              fillColor: Colors.black,
              child: Text('Select', style: TextStyle(color: Colors.white),),
              onPressed: (){
                setIp(availablePCs[index].ip);
                getConnectedIp();
              },
            ) :
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              fillColor: Colors.black,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_right, color: Colors.white,),
                    Container(
                        child: Text('Selected', style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NetworkDevice {
  String ip;
  String port;

  NetworkDevice({this.ip,this.port});
}
