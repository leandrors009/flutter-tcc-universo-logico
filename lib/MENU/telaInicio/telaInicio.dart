import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universo_logico/DADOS/carregamentoImagens/carregamentoImagens.dart';
import 'package:universo_logico/MENU/telaIntroducao/telaIntroducao.dart';
import 'package:universo_logico/MENU/telaJogos/telaJogos.dart';

class TelaInicio extends StatefulWidget {
  @override
  TelaInicioState createState() => TelaInicioState();
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

class TelaInicioState extends State<TelaInicio> {
  Timer temporizador;
  var opacidade = 0.0;
  var carregamento = 0;
  var nomeUsuario;
  var emailUsuario;

  void buscarCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nomeUsuario = prefs.getString('nome');
  }

  @override
  void initState() {
    super.initState();
    buscarCache();

    //TELA DE JOGOS
    Imagens.fundoJogos = Image.asset("assets/telaJogos/fundoTelaJogos.png");
    Imagens.capaJogoParImpar = Image.asset("assets/telaJogos/1.png");
    Imagens.capaJogoVelha = Image.asset("assets/telaJogos/2.png");
    Imagens.capaJogoOrdenarNumeros = Image.asset("assets/telaJogos/3.png");
    Imagens.capaMemorizarCores = Image.asset("assets/telaJogos/4.png");
    //JOGOS
    Imagens.fundoParImpar = Image.asset("assets/telaJogos/fundoJogos/parImpar/fundoParImpar.png");
    Imagens.fundoSelecaoOrdenarNumeros = Image.asset("assets/telaJogos/fundoJogos/ordenarNumeros/fundoSelecaoOrdenarNumeros.png");
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushAndRemoveUntil(
            context,
            FadeRoute(
                page: (nomeUsuario == null) ? TelaIntroducao() : TelaJogos()),
            (Route<dynamic> route) => false));
    temporizador = Timer.periodic(Duration(milliseconds: 60), (Timer t) {
      setState(() {
        if (opacidade < 0.9 && carregamento == 10)
          opacidade += 0.1;
        else if (carregamento != 10)
          carregamento += 1;
        else if (opacidade >= 0.9 && carregamento == 10) temporizador.cancel();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(Imagens.fundoJogos.image, context);
    precacheImage(Imagens.capaJogoParImpar.image, context);
    precacheImage(Imagens.capaJogoVelha.image, context);
    precacheImage(Imagens.capaJogoOrdenarNumeros.image, context);
    precacheImage(Imagens.capaMemorizarCores.image, context);
    precacheImage(Imagens.fundoParImpar.image, context);
    precacheImage(Imagens.fundoSelecaoOrdenarNumeros.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(22, 12, 127, 1.0)),
          ),
          Opacity(
            opacity: opacidade,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        width: 200,
                        image: AssetImage(
                          'assets/icone_entrada.png',
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Universo Lógico",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'LemonMilk',
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                (nomeUsuario == null
                    ? Container()
                    : Expanded(
                        flex: 1,
                        child: Text(
                          "Oi, $nomeUsuario :D",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontFamily: 'CaviarDreams',
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Colors.yellow,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50.0),
                      ),
                      Text(
                        "Aplicativo que visa o\nraciocínio lógico para crianças",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'CaviarDreams',
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
