import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universo_logico/MENU/telaLogin/cadastro.dart';
import 'dart:async';
import 'senha.dart';
import '../telaJogos/telaJogos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final bd = Firestore.instance;

  final formKey = new GlobalKey<FormState>();
  String email, senha;

  void adicionarCache(nomeUsuario, emailUsuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailUsuario);
    prefs.setString('nome', nomeUsuario);
  }

  void verificarLogin() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (await (Connectivity().checkConnectivity()) ==
          ConnectivityResult.none) {
        showInSnackBar("CONECTE-SE NA INTERNET!");
      } else {
        bd
            .collection("usuarios")
            .where("email", isEqualTo: '$email')
            .where("senha", isEqualTo: '$senha')
            .getDocuments()
            .then((usuarioValido) {
          if (usuarioValido.documents.isNotEmpty) {
            var dadosUsuario = usuarioValido.documents[0].data;
            var nomeUsuario = dadosUsuario['nome'];
            adicionarCache(nomeUsuario, email);
            showInSnackBar("LOGIN REALIZADO!");
          } else {
            showInSnackBar("USUÁRIO NÃO ENCONTRADO!");
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(15, 35, 61, 1.0),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: Form(
                  key: formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                        child: new Image.asset(
                            'assets/telaLogin/login_image.png',
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.contain),
                      ),
                      SizedBox(height: 30),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(splashColor: Colors.transparent),
                        child: TextFormField(
                          validator: (valor) =>
                              valor.isEmpty ? "Digite um email válido!" : null,
                          onSaved: (valor) => email = valor,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white,
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'CaviarDreams'),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(20, 50, 73, 1.0),
                                    width: 2,
                                    style: BorderStyle.solid)),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(20, 50, 73, 1.0),
                                    width: 2,
                                    style: BorderStyle.solid)),
                            errorBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(130, 50, 59, 1.0),
                                    width: 2,
                                    style: BorderStyle.solid)),
                            focusedErrorBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(130, 50, 59, 1.0),
                                    width: 2,
                                    style: BorderStyle.solid)),
                            fillColor: Color.fromRGBO(11, 26, 45, 1.0),
                            filled: true,
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'AntiPastoPro'),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(splashColor: Colors.transparent),
                        child: TextFormField(
                          validator: (valor) =>
                              valor.isEmpty ? "Digite uma senha válida!" : null,
                          onSaved: (valor) => senha = valor,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.white,
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'CaviarDreams'),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(20, 50, 73, 1.0),
                                    width: 2,
                                    style: BorderStyle.solid)),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(20, 50, 73, 1.0),
                                    width: 2,
                                    style: BorderStyle.solid)),
                            errorBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(130, 50, 59, 1.0),
                                    width: 2,
                                    style: BorderStyle.solid)),
                            focusedErrorBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(130, 50, 59, 1.0),
                                    width: 2,
                                    style: BorderStyle.solid)),
                            fillColor: Color.fromRGBO(11, 26, 45, 1.0),
                            filled: true,
                            hintText: "Senha",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'AntiPastoPro'),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => {
                          Navigator.push(
                              context, FadeRoute(page: AlterarSenha()))
                        },
                        child: Text('Esqueceu a senha?',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'AntiPastoPro'),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        highlightColor: Colors.white54,
                        splashColor: Colors.white54,
                        height: 60,
                        onPressed: verificarLogin,
                        child: Text("ENTRAR",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'LemonMilk')),
                        color: Color.fromRGBO(69, 194, 218, 1.0),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                      ),
                      SizedBox(height: 15),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 60,
                        highlightColor: Colors.white54,
                        splashColor: Colors.white54,
                        onPressed: () => {
                          Navigator.push(context, FadeRoute(page: Cadastrar()))
                        },
                        child: Text("CRIAR CONTA",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'LemonMilk')),
                        color: Color.fromRGBO(15, 35, 61, 1.0),
                        shape: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(30, 80, 106, 1.0),
                                width: 2,
                                style: BorderStyle.solid)),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
            )),
      ),
    );
  }

  void showInSnackBar(String value) {
    if (value == "CONECTE-SE NA INTERNET!") {
      Flushbar(
        padding: EdgeInsets.all(10),
        borderRadius: 8,
        icon: Icon(
          Icons.signal_wifi_off,
          size: 28,
          color: Colors.white,
        ),
        backgroundGradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade200],
          stops: [0.5, 1],
        ),
        boxShadows: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        duration: Duration(seconds: 3),
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        title: "CONECTE-SE NA INTERNET",
        message: "Conecte-se na internet para realizar o cadastro.",
      ).show(context);
    }
    if (value == "USUÁRIO NÃO ENCONTRADO!") {
      Flushbar(
        padding: EdgeInsets.all(10),
        borderRadius: 8,
        icon: Icon(
          Icons.person_outline,
          size: 28,
          color: Colors.white,
        ),
        backgroundGradient: LinearGradient(
          colors: [Colors.red.shade600, Colors.red.shade200],
          stops: [0.5, 1],
        ),
        boxShadows: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        duration: Duration(seconds: 3),
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        title: "USUÁRIO NÃO ENCONTRADO",
        message: "Utilize um email e senha válidos ou cadastre-se.",
      ).show(context);
    }
    if (value == "LOGIN REALIZADO!") {
      Flushbar(
        padding: EdgeInsets.all(10),
        borderRadius: 8,
        icon: Icon(
          Icons.account_circle,
          size: 28,
          color: Colors.white,
        ),
        backgroundGradient: LinearGradient(
          colors: [Colors.green.shade600, Colors.green.shade200],
          stops: [0.5, 1],
        ),
        boxShadows: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        duration: Duration(seconds: 3),
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        title: "LOGIN REALIZADO",
        message: "Redirecionando para a tela de jogos.",
      ).show(context);
      Timer(
          Duration(seconds: 5),
          () => Navigator.pushAndRemoveUntil(context,
              FadeRoute(page: TelaJogos()), (Route<dynamic> route) => false));
    }
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
