import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universo_logico/DADOS/caixasDialogos/dialogoOrdenarNumeros.dart';
import 'package:universo_logico/DADOS/variaveisEstaticas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: OrdenarNumerosNivel3());
  }
}

class OrdenarNumerosNivel3 extends StatefulWidget {
  @override
  OrdenarNumerosNivel3State createState() => new OrdenarNumerosNivel3State();
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

class OrdenarNumerosNivel3State extends State<OrdenarNumerosNivel3> {
  List<List<List<int>>> ordemNumerosTotal;
  List<List<int>> ordemNumerosEscolhida;
  String textoCronometro = "00:00:00";
  int cronometroIniciado = 0;
  final cronometro = new Stopwatch();
  bool valorCheckbox = VariaveisEstaticas.checkBoxCronometro;

  @override
  void initState() {
    super.initState();
    ordemNumerosTotal = [
      [
        [2, 21, 10, 14, 4],
        [7, 9, 6, 3, 5],
        [17, 1, 8, 23, 18],
        [24, 11, 13, 12, 15],
        [16, 22, 20, 0, 19]
      ],
      [
        [2, 6, 13, 3, 10],
        [1, 4, 0, 5, 12],
        [21, 24, 7, 23, 9],
        [18, 11, 20, 19, 22],
        [15, 16, 8, 17, 14]
      ],
      [
        [11, 1, 4, 5, 10],
        [7, 2, 15, 17, 9],
        [8, 14, 12, 24, 19],
        [21, 6, 23, 18, 20],
        [22, 0, 16, 3, 13]
      ],
      [
        [8, 3, 11, 4, 5],
        [2, 1, 14, 10, 23],
        [6, 12, 13, 19, 24],
        [18, 21, 0, 22, 20],
        [16, 9, 7, 17, 15]
      ],
      [
        [20, 18, 14, 1, 13],
        [16, 8, 10, 3, 5],
        [23, 6, 21, 4, 12],
        [17, 2, 22, 15, 9],
        [7, 0, 11, 19, 24]
      ],
    ];
    ordemNumerosEscolhida = ordemNumerosTotal[Random().nextInt(5)];
  }

  void iniciarCronometro() {
    if (cronometroIniciado == 1) {
      cronometro.start();
      contarCronometro();
    }
  }

  void contarCronometro() {
    new Timer(Duration(seconds: 1), funcaoCronometro);
  }

  void funcaoCronometro() {
    if (this.mounted) {
      if (cronometro.isRunning) {
        contarCronometro();
      }
      setState(() {
        textoCronometro =
            cronometro.elapsed.inHours.toString().padLeft(2, '0') +
                ':' +
                (cronometro.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
                ':' +
                (cronometro.elapsed.inSeconds % 60).toString().padLeft(2, '0');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OnlyOnePointerRecognizerWidget(
          child: ordemNumerosCorpo(),
        ),
      ),
    );
  }

  Widget ordemNumerosCorpo() {
    int tamanhoGrid = ordemNumerosEscolhida.length;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
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
                      '/selecaoOrdenarNumeros',
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
                "Nível 3 (5x5)",
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
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white),
            child: GridView.builder(
              physics: new NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: tamanhoGrid,
              ),
              itemBuilder: construirOrdem,
              itemCount: tamanhoGrid * tamanhoGrid,
            ),
          ),
        ),
        valorCheckbox == false
            ? Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  textoCronometro,
                  style: TextStyle(
                    fontFamily: 'Aller',
                    fontSize: 50,
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
      ],
    );
  }

  Widget construirOrdem(BuildContext context, int index) {
    int tamanhoGrid = 5;
    int x = 0, y = 0;
    x = (index / tamanhoGrid).floor();
    y = (index % tamanhoGrid);

    if (ordemNumerosEscolhida[x][y] == 0) {
      return GestureDetector(
          child: GridTile(
        child: Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
        ),
      ));
    } else {
      return GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.delta.dy < 0) {
              setState(() {
                if (x != 0 && ordemNumerosEscolhida[x - 1][y] == 0) {
                  if (valorCheckbox == false) {
                    cronometroIniciado++;
                    iniciarCronometro();
                  }
                  ordemNumerosEscolhida[x - 1][y] = ordemNumerosEscolhida[x][y];
                  ordemNumerosEscolhida[x][y] = 0;
                  checarVitoria();
                }
              });
            } else if (details.delta.dy > 0) {
              setState(() {
                if (x != 4 && ordemNumerosEscolhida[x + 1][y] == 0) {
                  if (valorCheckbox == false) {
                    cronometroIniciado++;
                    iniciarCronometro();
                  }
                  ordemNumerosEscolhida[x + 1][y] = ordemNumerosEscolhida[x][y];
                  ordemNumerosEscolhida[x][y] = 0;
                  checarVitoria();
                }
              });
            }
          },
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 0) {
              setState(() {
                if (y != 4 && ordemNumerosEscolhida[x][y + 1] == 0) {
                  if (valorCheckbox == false) {
                    cronometroIniciado++;
                    iniciarCronometro();
                  }
                  ordemNumerosEscolhida[x][y + 1] = ordemNumerosEscolhida[x][y];
                  ordemNumerosEscolhida[x][y] = 0;
                  checarVitoria();
                }
              });
            } else if (details.delta.dx < 0) {
              setState(() {
                if (y != 0 && ordemNumerosEscolhida[x][y - 1] == 0) {
                  if (valorCheckbox == false) {
                    cronometroIniciado++;
                    iniciarCronometro();
                  }
                  ordemNumerosEscolhida[x][y - 1] = ordemNumerosEscolhida[x][y];
                  ordemNumerosEscolhida[x][y] = 0;
                  checarVitoria();
                }
              });
            }
          },
          child: GridTile(
            child: Container(
              margin: EdgeInsets.all(3),
              child: Center(
                child: Text(
                  ordemNumerosEscolhida[x][y].toString(),
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'LemonMilk',
                    color: alterarCor(ordemNumerosEscolhida[x][y], x, y) !=
                            Colors.white
                        ? Colors.white
                        : Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 5.0,
                        color: alterarCor(ordemNumerosEscolhida[x][y], x, y) !=
                                Colors.white
                            ? Colors.black
                            : Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(20),
                color: alterarCor(ordemNumerosEscolhida[x][y], x, y),
              ),
            ),
          ));
    }
  }

  Color alterarCor(int valorBloco, int coordX, int coordY) {
    Color corCorrespondente = Colors.white;
    if (valorBloco == 1 && coordX == 0 && coordY == 0) {
      corCorrespondente = Colors.red;
    }
    if (valorBloco == 2 && coordX == 0 && coordY == 1) {
      corCorrespondente = Colors.blue;
    }
    if (valorBloco == 3 && coordX == 0 && coordY == 2) {
      corCorrespondente = Colors.green;
    }
    if (valorBloco == 4 && coordX == 0 && coordY == 3) {
      corCorrespondente = Colors.orange;
    }
    if (valorBloco == 5 && coordX == 0 && coordY == 4) {
      corCorrespondente = Colors.pink;
    }
    if (valorBloco == 6 && coordX == 1 && coordY == 0) {
      corCorrespondente = Colors.yellow;
    }
    if (valorBloco == 7 && coordX == 1 && coordY == 1) {
      corCorrespondente = Colors.blueGrey;
    }
    if (valorBloco == 8 && coordX == 1 && coordY == 2) {
      corCorrespondente = Colors.tealAccent;
    }
    if (valorBloco == 9 && coordX == 1 && coordY == 3) {
      corCorrespondente = Colors.lightBlueAccent;
    }
    if (valorBloco == 10 && coordX == 1 && coordY == 4) {
      corCorrespondente = Colors.greenAccent;
    }
    if (valorBloco == 11 && coordX == 2 && coordY == 0) {
      corCorrespondente = Colors.redAccent;
    }
    if (valorBloco == 12 && coordX == 2 && coordY == 1) {
      corCorrespondente = Colors.brown;
    }
    if (valorBloco == 13 && coordX == 2 && coordY == 2) {
      corCorrespondente = Colors.pinkAccent;
    }
    if (valorBloco == 14 && coordX == 2 && coordY == 3) {
      corCorrespondente = Colors.green;
    }
    if (valorBloco == 15 && coordX == 2 && coordY == 4) {
      corCorrespondente = Colors.blueGrey;
    }
    if (valorBloco == 16 && coordX == 3 && coordY == 0) {
      corCorrespondente = Colors.indigoAccent;
    }
    if (valorBloco == 17 && coordX == 3 && coordY == 1) {
      corCorrespondente = Colors.lightGreen;
    }
    if (valorBloco == 18 && coordX == 3 && coordY == 2) {
      corCorrespondente = Colors.deepOrange;
    }
    if (valorBloco == 19 && coordX == 3 && coordY == 3) {
      corCorrespondente = Colors.tealAccent;
    }
    if (valorBloco == 20 && coordX == 3 && coordY == 4) {
      corCorrespondente = Colors.orange;
    }
    if (valorBloco == 21 && coordX == 4 && coordY == 0) {
      corCorrespondente = Colors.pink;
    }
    if (valorBloco == 22 && coordX == 4 && coordY == 1) {
      corCorrespondente = Colors.amber;
    }
    if (valorBloco == 23 && coordX == 4 && coordY == 2) {
      corCorrespondente = Colors.cyanAccent;
    }
    if (valorBloco == 24 && coordX == 4 && coordY == 3) {
      corCorrespondente = Colors.yellow;
    }
    return corCorrespondente;
  }

  void atualizarProgresso() async {
    var emailUsuario;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailUsuario = prefs.getString('email');
    final bd = Firestore.instance;
    bd
        .collection("progresso")
        .document('$emailUsuario')
        .updateData({'jogo3_nivel3': true});
  }

  void checarVitoria() {
    if (ordemNumerosEscolhida[0][0] == 1) {
      if (ordemNumerosEscolhida[0][1] == 2) {
        if (ordemNumerosEscolhida[0][2] == 3) {
          if (ordemNumerosEscolhida[0][3] == 4) {
            if (ordemNumerosEscolhida[0][4] == 5) {
              if (ordemNumerosEscolhida[1][0] == 6) {
                if (ordemNumerosEscolhida[1][1] == 7) {
                  if (ordemNumerosEscolhida[1][2] == 8) {
                    if (ordemNumerosEscolhida[1][3] == 9) {
                      if (ordemNumerosEscolhida[1][4] == 10) {
                        if (ordemNumerosEscolhida[2][0] == 11) {
                          if (ordemNumerosEscolhida[2][1] == 12) {
                            if (ordemNumerosEscolhida[2][2] == 13) {
                              if (ordemNumerosEscolhida[2][3] == 14) {
                                if (ordemNumerosEscolhida[2][4] == 15) {
                                  if (ordemNumerosEscolhida[3][0] == 16) {
                                    if (ordemNumerosEscolhida[3][1] == 17) {
                                      if (ordemNumerosEscolhida[3][2] == 18) {
                                        if (ordemNumerosEscolhida[3][3] == 19) {
                                          if (ordemNumerosEscolhida[3][4] ==
                                              20) {
                                            if (ordemNumerosEscolhida[4][0] ==
                                                21) {
                                              if (ordemNumerosEscolhida[4][1] ==
                                                  22) {
                                                if (ordemNumerosEscolhida[4]
                                                        [2] ==
                                                    23) {
                                                  if (ordemNumerosEscolhida[4]
                                                          [3] ==
                                                      24) {
                                                    if (ordemNumerosEscolhida[4]
                                                            [4] ==
                                                        0) {
                                                      cronometro.stop();
                                                      atualizarProgresso();
                                                      showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              OrdenarNumerosDialog(
                                                                tempo: valorCheckbox ==
                                                                        false
                                                                    ? textoCronometro
                                                                    : "",
                                                              ));
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    return null;
  }
}
