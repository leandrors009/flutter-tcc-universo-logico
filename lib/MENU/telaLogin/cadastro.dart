import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:universo_logico/MENU/telaLogin/login.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Cadastrar extends StatefulWidget {
  @override
  CadastrarState createState() => CadastrarState();
}

class CadastrarState extends State<Cadastrar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final bd = Firestore.instance;

  void cadastrarUsuario() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (await (Connectivity().checkConnectivity()) ==
          ConnectivityResult.none) {
        showInSnackBar("CONECTE-SE NA INTERNET!");
      } else {
        bd
            .collection("usuarios")
            .document("$email")
            .get()
            .then((usuarioExistente) {
          if (usuarioExistente.exists) {
            showInSnackBar("USUÁRIO JÁ CADASTRADO!");
          } else {
            bd.collection("usuarios").document('$email').setData({
              'nome': '$nome',
              'email': '$email',
              'senha': '$senha',
              'dataNascimento': '$dataNascimento'
            });
            bd.collection("progresso").document('$email').setData({
              'jogo3_nivel1': false,
              'jogo3_nivel2': false,
              'jogo3_nivel3': false
            });
            showInSnackBar("CADASTRO REALIZADO!");
          }
        });
      }
    }
  }

  final formKey = new GlobalKey<FormState>();
  String nome, email, senha, dataNascimento;
  var dataNascimentoController = new TextEditingController();

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
                      child: new Image.asset('assets/telaLogin/login_image.png',
                          width: 200.0, height: 200.0, fit: BoxFit.contain),
                    ),
                    SizedBox(height: 30),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(splashColor: Colors.transparent),
                      child: TextFormField(
                        validator: (valor) =>
                            valor.isEmpty ? "Digite um nome válido!" : null,
                        onSaved: (valor) => nome = valor,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.white,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'CaviarDreams'),
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.account_circle, color: Colors.white),
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
                          fillColor: Color.fromRGBO(11, 26, 45, 1.0),
                          filled: true,
                          hintText: "Nome",
                          hintStyle: TextStyle(
                              color: Colors.white, fontFamily: 'AntiPastoPro'),
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
                            valor.isEmpty ? "Digite um email válido!" : null,
                        onSaved: (valor) => email = valor,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.white,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'CaviarDreams'),
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.alternate_email, color: Colors.white),
                          focusedBorder: new OutlineInputBorder(
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
                          enabledBorder: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(20, 50, 73, 1.0),
                                  width: 2,
                                  style: BorderStyle.solid)),
                          fillColor: Color.fromRGBO(11, 26, 45, 1.0),
                          filled: true,
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: Colors.white, fontFamily: 'AntiPastoPro'),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(splashColor: Colors.transparent),
                      child: TextFormField(
                        obscureText: true,
                        validator: (valor) =>
                            valor.isEmpty ? "Digite uma senha válida!" : null,
                        onSaved: (valor) => senha = valor,
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
                          enabledBorder: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(20, 50, 73, 1.0),
                                  width: 2,
                                  style: BorderStyle.solid)),
                          fillColor: Color.fromRGBO(11, 26, 45, 1.0),
                          filled: true,
                          hintText: "Senha",
                          hintStyle: TextStyle(
                              color: Colors.white, fontFamily: 'AntiPastoPro'),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(splashColor: Colors.transparent),
                      child: TextFormField(
                        controller: dataNascimentoController,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true,
                              minTime: DateTime(2000, 1, 1),
                              maxTime: DateTime(2022, 12, 31),
                              locale: LocaleType.pt, onConfirm: (date) {
                            setState(() {
                              dataNascimentoController.text =
                                  '${date.day}/${date.month}/${date.year}';
                            });
                          });
                        },
                        validator: (valor) => valor.isEmpty
                            ? "Selecione uma data de nascimento válida!"
                            : null,
                        onSaved: (valor) => dataNascimento = valor,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.white,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'CaviarDreams'),
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.calendar_today, color: Colors.white),
                          focusedBorder: new OutlineInputBorder(
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
                          enabledBorder: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(20, 50, 73, 1.0),
                                  width: 2,
                                  style: BorderStyle.solid)),
                          fillColor: Color.fromRGBO(11, 26, 45, 1.0),
                          filled: true,
                          hintText: "Data de Nascimento",
                          hintStyle: TextStyle(
                              color: Colors.white, fontFamily: 'AntiPastoPro'),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      highlightColor: Colors.white54,
                      splashColor: Colors.white54,
                      height: 60,
                      onPressed: () => cadastrarUsuario(),
                      child: Text("CADASTRAR",
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
                        Navigator.push(context, FadeRoute(page: Login()))
                      },
                      child: Text("ENTRAR",
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
                ),
              ),
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
    if (value == "USUÁRIO JÁ CADASTRADO!") {
      Flushbar(
        padding: EdgeInsets.all(10),
        borderRadius: 8,
        icon: Icon(
          Icons.email,
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
        title: "USUÁRIO JÁ CADASTRADO",
        message: "Utilize outro email ou realize o login.",
      ).show(context);
    }
    if (value == "CADASTRO REALIZADO!") {
      Flushbar(
        padding: EdgeInsets.all(10),
        borderRadius: 8,
        icon: Icon(
          Icons.person_add,
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
        title: "CADASTRO REALIZADO",
        message: "Redirecionando para a tela de login.",
      ).show(context);
      Timer(
          Duration(seconds: 5),
          () => Navigator.pushAndRemoveUntil(context, FadeRoute(page: Login()),
              (Route<dynamic> route) => false));
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
