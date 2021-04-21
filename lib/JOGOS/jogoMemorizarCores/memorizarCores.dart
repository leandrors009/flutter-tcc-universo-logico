import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MemorizarCores extends StatefulWidget {
  @override
  MemorizarCoresState createState() => new MemorizarCoresState();
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

class MemorizarCoresState extends State<MemorizarCores> {
  Color blocoAzul = Colors.blue;
  Color blocoVermelho = Colors.red;
  Color blocoAmarelo = Colors.yellow;
  Color blocoVerde = Colors.green;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, '/telaJogos', (Route<dynamic> route) => false);
        return false;
      },
      child: OnlyOnePointerRecognizerWidget(
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
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
                        flex: 8,
                        child: Text(
                          "Memorizar Cores",
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
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              alterarCor(1);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.greenAccent, width: 3),
                                color: blocoVerde,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              alterarCor(2);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.redAccent, width: 3),
                                color: blocoVermelho,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              alterarCor(3);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.yellowAccent, width: 3),
                                color: blocoAmarelo,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              alterarCor(4);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.lightBlueAccent, width: 3),
                                color: blocoAzul,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void alterarCor(int indiceBloco) {
    if (indiceBloco == 1) {
      setState(() {
        blocoVerde = Colors.white;
        Timer(Duration(milliseconds: 300), () {
          setState(() {
            blocoVerde = Colors.green;
          });
        });
      });
    }
    if (indiceBloco == 2) {
      setState(() {
        blocoVermelho = Colors.white;
        Timer(Duration(milliseconds: 300), () {
          setState(() {
            blocoVermelho = Colors.red;
          });
        });
      });
    }
    if (indiceBloco == 3) {
      setState(() {
        blocoAmarelo = Colors.white;
        Timer(Duration(milliseconds: 300), () {
          setState(() {
            blocoAmarelo = Colors.yellow;
          });
        });
      });
    }
    if (indiceBloco == 4) {
      setState(() {
        blocoAzul = Colors.white;
        Timer(Duration(milliseconds: 300), () {
          setState(() {
            blocoAzul = Colors.blue;
          });
        });
      });
    }
  }
}
