import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import 'package:flutter_app3/api_response.dart';
import 'package:flutter_app3/firebases/firebase_service.dart';
import 'package:flutter_app3/home_page.dart';

import 'package:flutter_app3/Cadastro_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _tEmail = TextEditingController();
  final _tSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("la mia app"),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Form(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _tEmail,
                  decoration: InputDecoration(labelText: 'Accedere'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _tSenha,
                  decoration: InputDecoration(labelText: "parola d' ordine"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text('accerdi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white
                    ),),
                  onPressed: _onClickLogin,
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 16.0),
                child: GoogleSignInButton(
                  text: 'Sign in with Google',
                  onPressed: () async {
                    final service = FirebaseService();
                    ApiResponse response = await service.loginGoogle();
                    if (response.ok) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => HomePage()),
                      );
                    }
                  },
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 16.0),
                //funiona como um butao so que é um link
                child: InkWell(
                  onTap: _onClickCad,
                  child: Text('Cadastrar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue,
                    ),),

                ),
              ),
            ],
          ),
        )
    );
  }

  void _onClickLogin() async {
    String email = _tEmail.text;
    String senha = _tSenha.text;

    ApiResponse response = await FirebaseService().login(email, senha);
    if (response.ok) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()));
    }
  }

  void _onClickCad() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastroPage()));
  }
}

  



