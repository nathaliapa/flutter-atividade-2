import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app3/firebases/firebase_service.dart';
import 'package:flutter_app3/login_page.dart';
import 'package:flutter_app3/ui/home_page_gif.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    Future<FirebaseUser> future = FirebaseAuth.instance.currentUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('la mia app'),
      ),
      drawer: Drawer(
        child: ListView(
          children:<Widget> [
            FutureBuilder<FirebaseUser>(
              future: future,
              builder: (context, snapshot) {
                FirebaseUser user = snapshot.data;
                return UserAccountsDrawerHeader(
                  accountName: Text(user.displayName ?? ""),
                  accountEmail: Text(user.email),
                  currentAccountPicture: user.photoUrl != null
                      ? CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl),)
                      : FlutterLogo(),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.image,),
              title: Text('Trova GIF'),
              onTap: () => _onClickGif(context),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app,),
              title: Text('Logaut'),
              onTap: () => _onClickLogout(context),
            ),
           ],
        ),
      ),
      body: Card(
          child: Column(
          children:<Widget> [
            Image.asset('assets/images/foto.gif'
            ),
            // ignore: deprecated_member_use
             RaisedButton(
                child: Text("Trova GIF",style: TextStyle(
                    color: Colors.white,fontSize: 25,
                ),),
                color: Colors.blueAccent,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePageGif(),
                    ),
                  );
                },),
          ],
        ),
      ),
    );
  }
}

  _onClickGif(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => HomePageGif()),
    );
}

 _onClickLogout(BuildContext context) async{
  FirebaseService().logout();
  Navigator.pop(context);
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => LoginPage()),
  );
}