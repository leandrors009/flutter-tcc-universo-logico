import 'package:flutter/material.dart';

class ParImparDialog extends StatelessWidget {
  final int pontuacao;

  ParImparDialog({
    this.pontuacao,
  });

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                pontuacao >= 60 ? "Você Ganhou :D" : "Você Perdeu :(",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'LemonMilk',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                pontuacao >= 60
                    ? "Você ganhou o jogo do Par e Ímpar, parabéns!"
                    : "Você não conseguiu ganhar o jogo do Par e Ímpar!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23.0, fontFamily: 'AntiPastoPro'),
              ),
              SizedBox(height: 15.0),
              Text(
                pontuacao >= 60
                    ? "Você quer jogar novamente?"
                    : "Tente novamente para conseguir mais pontos!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23.0, fontFamily: 'AntiPastoPro'),
              ),
              SizedBox(height: 20.0),
              pontuacao == null
                  ? Container()
                  : Text(
                      "Pontuação: $pontuacao",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, fontFamily: 'LemonMilk'),
                    ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        elevation: 2,
                        highlightColor: Colors.transparent,
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        splashColor: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/telaJogos', (Route<dynamic> route) => false);
                        },
                        child: Text(
                          "Jogar Outro Jogo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'AntiPastoPro',
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: RaisedButton(
                        elevation: 2,
                        color: Colors.green,
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).popAndPushNamed('/par&Impar');
                        },
                        child: Text(
                          "Jogar Novamente",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'AntiPastoPro',
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, '/par&Impar', (Route<dynamic> route) => false);
        return false;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }
}
