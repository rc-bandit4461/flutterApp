import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
//                color: Colors.blue,
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.white])),
              child: Center(
                child: CircleAvatar(
//                backgroundImage: NetworkImage("https://picsum.photos/200"),
                  backgroundImage: AssetImage("assets/images/logo.png"),
                  radius: 70,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Quiz",
              ),
              onTap: () {
                print("Clicked on quiz");
//                Navigator.pushNamed(context, '/quiz');
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Quiz()));
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/');
                Navigator.pushNamed(context, '/quiz');
//                Navigator.push(context,MaterialPageRoute(
//                  builder: (context) => Quiz()
//                ));
//                Navigator.push(
//                    context, MaterialPageRoute(builder: (context) => Quiz()));
              },
            ),
            Divider(
              color: Colors.lightBlue,
            ),
            ListTile(
              title: Text("Camera"),
              onTap: () {
//                Navigator.pushNamed(context, '/camera');
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Camera()));
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/');
                Navigator.pushNamed(context, '/camera');
                print("Clicked on Camera");
              },
            ),
            Divider(
              color: Colors.cyan,
            ),
            ListTile(
              title: Text("Weather"),
              onTap: () {
//                Navigator.pushNamed(context, '/weather');
                // Navigator.push(context,MaterialPageRoute(builder: (context) => Weather()));
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/');

                Navigator.pushNamed(context, '/weather2');
//                Navigator.of(context).pop();
              },
            ),
            Divider(
              color: Colors.cyan,
            ),
            ListTile(
              title: Text("Gallery"),
              onTap: () {
//                Navigator.pushNamed(context, '/weather');
                // Navigator.push(context,MaterialPageRoute(builder: (context) => Gallery()));
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/');

                Navigator.pushNamed(context, '/gallery');
              },
            ),
            Divider(color: Colors.red),
            ListTile(
              title: Text("QR Code Scanner"),
              onTap: () {
//                Navigator.pushNamed(context, '/weather');
                // Navigator.push(context,MaterialPageRoute(builder: (context) => Gallery()));
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/');
                Navigator.pushNamed(context, '/qrcode');
              },
            ),
            ListTile(
              title: Text("Close"),
              onTap: () {
                print("Closing by popping? hmm");
                Navigator.of(context).pop();
              },
            ),
            Divider(
              indent: 20,
              thickness: 10,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
