import 'package:flutter/material.dart';

class OrdenarNumerosDialog extends StatelessWidget {
  final String tempo;

  OrdenarNumerosDialog({
    this.tempo,
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
                "Você ganhou :D",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'LemonMilk',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Você conseguiu ordenar todos os números, parabéns!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'AntiPastoPro',
                ),
              ),
              tempo == "" ? Container() : SizedBox(height: 15.0),
              tempo == ""
                  ? Container()
                  : Text(
                      "Tempo: $tempo",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontFamily: 'LemonMilk'),
                    ),
              tempo == "" ? SizedBox(height: 25.0) : SizedBox(height: 20),
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
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/selecaoOrdenarNumeros',
                              (Route<dynamic> route) => false);
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
            context, '/selecaoOrdenarNumeros', (Route<dynamic> route) => false);
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
