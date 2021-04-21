import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universo_logico/DADOS/caixasDialogos/dialogoPar&Impar.dart';
import 'dart:math';

import 'package:universo_logico/DADOS/carregamentoImagens/carregamentoImagens.dart';

class ParImpar extends StatefulWidget {
  @override
  ParImparState createState() => new ParImparState();
}

class OnlyOnePointerRecognizer extends OneSequenceGestureRecognizer {
  int _p = 0;
  @override
  void addPointer(PointerDownEvent event) {
    startTrackingPointer(event.pointer);
    if (_p == 0) {
      resolve(GestureDisposition.rejected);
      _p = event.pointer;
    } else {
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  String get debugDescription => 'only one pointer recognizer';

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    if (!event.down && event.pointer == _p) {
      _p = 0;
    }
  }
}

class OnlyOnePointerRecognizerWidget extends StatelessWidget {
  final Widget child;
  OnlyOnePointerRecognizerWidget({this.child});
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        OnlyOnePointerRecognizer:
            GestureRecognizerFactoryWithHandlers<OnlyOnePointerRecognizer>(
          () => OnlyOnePointerRecognizer(),
          (OnlyOnePointerRecognizer instance) {},
        ),
      },
      child: child,
    );
  }
}

class Numeros {
  int vermelho = 0;
  int verde = 0;
  int azul = 0;
  int valor = 0;
  double margem = 0;

  Numeros(int vermelho, int verde, int azul, double margem, int valor) {
    this.vermelho = vermelho;
    this.verde = verde;
    this.azul = azul;
    this.valor = valor;
    this.margem = margem;
  }
}

class ParImparState extends State<ParImpar> {
  void caixaDialogo() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ParImparDialog(
              pontuacao: pontuacao,
            ));
  }

  List<Widget> listaNumeros;
  static AudioCache playSom = AudioCache();
  int pontuacao = 0;

  void removerNumeros(index) {
    setState(() {
      listaNumeros.removeAt(index);
      if (listaNumeros.isEmpty) {
        caixaDialogo();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    playSom.clearCache();
    playSom.loadAll(['sons/ACERTO.mp3', 'sons/ERRO.mp3']);
    pontuacao = 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listaNumeros = gerarLista();
    pontuacao = 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, '/telaJogos', (Route<dynamic> route) => false);
        return false;
      },
      child: Scaffold(
          body: Container(
        color: Color.fromRGBO(22, 12, 127, 1.0),
        child: SafeArea(
          child: OnlyOnePointerRecognizerWidget(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Imagens.fundoParImpar.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/telaJogos',
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              "<",
                              style: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(3.0, 3.0),
                                    blurRadius: 5.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                                fontSize: 28,
                                fontFamily: 'LemonMilk',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 12,
                          child: Text(
                            "Par e Ímpar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 5.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                              fontSize: 25,
                              fontFamily: 'LemonMilk',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Text(
                              "$pontuacao",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(3.0, 3.0),
                                    blurRadius: 5.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                                fontFamily: 'LemonMilk',
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: listaNumeros,
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              decoration: new BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black,
                                    offset: new Offset(5.0, 5.0),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.19,
                              child: DragTarget(
                                builder: (context, List<int> numberData,
                                    rejectedData) {
                                  return Center(
                                      child: Text(
                                    "PAR",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontFamily: 'LemonMilk',
                                        fontWeight: FontWeight.bold),
                                  ));
                                },
                                onWillAccept: (data) {
                                  return true;
                                },
                                onAccept: (data) {
                                  if (data % 2 == 0) {
                                    playSom.play('sons/ACERTO.mp3');
                                    setState(() {
                                      pontuacao += 10;
                                    });
                                  } else {
                                    playSom.play('sons/ERRO.mp3');
                                  }
                                },
                              ),
                            ),
                            Container(
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black,
                                    offset: new Offset(5.0, 5.0),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.19,
                              child: DragTarget(
                                builder: (context, List<int> numberData,
                                    rejectedData) {
                                  return Center(
                                      child: Text(
                                    "ÍMPAR",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontFamily: 'LemonMilk',
                                        fontWeight: FontWeight.bold),
                                  ));
                                },
                                onWillAccept: (data) {
                                  return true;
                                },
                                onAccept: (data) {
                                  if (data % 2 != 0) {
                                    playSom.play('sons/ACERTO.mp3');
                                    pontuacao += 10;
                                  } else {
                                    playSom.play('sons/ERRO.mp3');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  List<Widget> gerarLista() {
    List<Numeros> numeros = new List();

    for (var i = 0; i < 10; i++) {
      numeros.add(Numeros(new Random().nextInt(255), new Random().nextInt(255),
          new Random().nextInt(255), 100, new Random().nextInt(100)));
    }

    List<Widget> listaNumeros = new List();

    for (int x = 0; x < 10; x++) {
      listaNumeros.add(Positioned(
        child: Draggable(
          data: numeros[x].valor,
          onDragCompleted: () {
            removerNumeros(x);
          },
          childWhenDragging: Container(),
          feedback: Card(
            elevation: 12,
            color: Color.fromARGB(
                255, numeros[x].vermelho, numeros[x].verde, numeros[x].azul),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(300)),
            child: Container(
              alignment: Alignment(0.0, 0.0),
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width * 0.33,
              child: Text(
                numeros[x].valor.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'LemonMilk',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          child: Card(
            elevation: 12,
            color: Color.fromARGB(
                255, numeros[x].vermelho, numeros[x].verde, numeros[x].azul),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(300)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width * 0.33,
              alignment: Alignment(0.0, 0.0),
              child: Text(
                numeros[x].valor.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'LemonMilk',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ));
    }
    return listaNumeros;
  }
}
