import 'package:flutter/material.dart';
import 'package:flutter_app3/api_response.dart';
import 'package:flutter_app3/firebases/firebase_service.dart';
import 'package:flutter_app3/home_page.dart';
import 'package:flutter_app3/login_page.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorEmail= TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("App per fotos"),
      ),
      body: Padding(
        padding:const EdgeInsets.only(top: 16.0),
        child: Column(
          children:<Widget> [
            Padding(
              padding:const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorNome ,
                decoration: InputDecoration(
                    labelText: 'Nome'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _controladorEmail,
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child:TextField(
                controller: _controladorSenha,
                decoration: InputDecoration(
                    labelText: "parola d' ordine",
                ),
              ),
            ),

            Padding(
              padding:const EdgeInsets.only(top: 16.0) ,
              // ignore: deprecated_member_use
              child:RaisedButton(
                onPressed: _onClickCadastro,
                child: Text("Cadastro"),
              ) ,
            )
          ],
        ),
      ),
    );
  }

  void _onClickCadastro() async {

    String nome = _controladorNome.text;
    String email = _controladorEmail.text;
    String senha = _controladorSenha.text;

    ApiResponse response = await FirebaseService().cadastrar(nome,email, senha);
    if (response.ok) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage()));
    }
  }

}
