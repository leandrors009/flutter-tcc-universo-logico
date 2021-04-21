import 'package:flutter/material.dart';
import 'package:universo_logico/MENU/telaLogin/login.dart';

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

final pages = [
  new PageViewModel(
      const Color(0xFF122a46),
      'assets/telaIntroducao/icone.png',
      'Universo Lógico',
      'Olá, seja bem vindo! Esse jogo foi desenvolvido para um Trabalho de Conclusão de Curso de Informática da Etec - Rodrigues de Abreu.',
      'assets/telaIntroducao/bolinha.png',
      ''),
  new PageViewModel(
      const Color(0xFF006400),
      'assets/telaIntroducao/cerebro.png',
      'Objetivo do App',
      'Esse aplicativo visa o aprimoramento do raciocínio lógico das crianças ao longo de diversos jogos e desafios com o objetivo de prepará-los para o dia-a-dia.',
      'assets/telaIntroducao/bolinha.png',
      ''),
  new PageViewModel(
      const Color(0xFFFF682D),
      'assets/telaIntroducao/cadastro.png',
      'Cadastro',
      'Antes de iniciarmos os jogos, gostaríamos de pedir que o responsável cadastre a criança para que seu registro e desempenho sejam registrados futuramente.',
      'assets/telaIntroducao/bolinha.png',
      'Cadastrar'),
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  Page({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        color: viewModel.color,
        child: new Opacity(
          opacity: percentVisible,
          child: Stack(
            children: <Widget>[
              new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Transform(
                      transform: new Matrix4.translationValues(
                          0.0, 50.0 * (1.0 - percentVisible), 0.0),
                      child: new Padding(
                        padding: new EdgeInsets.only(bottom: 25.0),
                        child: new Image.asset(viewModel.heroAssetPath,
                            width: 200.0, height: 200.0),
                      ),
                    ),
                    new Transform(
                      transform: new Matrix4.translationValues(
                          0.0, 30.0 * (1.0 - percentVisible), 0.0),
                      child: new Padding(
                        padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: new Text(
                          viewModel.title,
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: 'LemonMilk',
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                    new Transform(
                      transform: new Matrix4.translationValues(
                          0.0, 30.0 * (1.0 - percentVisible), 0.0),
                      child: new Padding(
                        padding: new EdgeInsets.only(
                            bottom: 75.0, left: 10, right: 10),
                        child: new Text(
                          viewModel.body,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: 'CaviarDreams',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ]),
              viewModel.textoCadastro != ""
                  ? Positioned(
                      top: MediaQuery.of(context).size.height - 55,
                      left: MediaQuery.of(context).size.width - 157,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        highlightColor: Colors.red,
                        splashColor: Colors.red,
                        onPressed: () => {Navigator.push(context, FadeRoute(page: Login()))},
                        child: Text(viewModel.textoCadastro,
                            style: TextStyle(
                                fontFamily: 'LemonMilk',
                                fontSize: 18,
                                color: Colors.white)),
                      ),
                    )
                  : Container(width: 0, height: 0),
            ],
          ),
        ));
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;
  final String textoCadastro;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.iconAssetPath,
    this.textoCadastro,
  );
}
