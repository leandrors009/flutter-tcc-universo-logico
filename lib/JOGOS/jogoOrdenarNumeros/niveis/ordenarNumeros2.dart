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
        home: OrdenarNumerosNivel2());
  }
}

class OrdenarNumerosNivel2 extends StatefulWidget {
  @override
  OrdenarNumerosNivel2State createState() => new OrdenarNumerosNivel2State();
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

class OrdenarNumerosNivel2State extends State<OrdenarNumerosNivel2> {
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
        [12, 5, 3, 10],
        [1, 8, 4, 11],
        [6, 7, 9, 2],
        [13, 0, 14, 15]
      ],
      [
        [2, 14, 4, 7],
        [1, 0, 13, 3],
        [11, 10, 6, 9],
        [5, 8, 15, 12]
      ],
      [
        [15, 10, 6, 7],
        [12, 1, 2, 3],
        [9, 13, 14, 11],
        [4, 0, 8, 5]
      ],
      [
        [1, 2, 7, 14],
        [9, 5, 3, 11],
        [15, 12, 10, 13],
        [8, 6, 4, 0]
      ],
      [
        [4, 1, 9, 7],
        [12, 5, 2, 10],
        [13, 8, 3, 15],
        [14, 6, 11, 0]
      ],
      [
        [5, 9, 4, 7],
        [14, 12, 2, 0],
        [1, 3, 6, 8],
        [13, 11, 10, 15]
      ],
      [
        [7, 3, 2, 4],
        [6, 9, 10, 0],
        [5, 13, 14, 8],
        [11, 12, 1, 15]
      ],
      [
        [6, 12, 9, 10],
        [1, 7, 15, 8],
        [11, 5, 14, 2],
        [13, 0, 3, 4]
      ],
      [
        [10, 2, 6, 9],
        [14, 5, 8, 0],
        [7, 1, 4, 3],
        [13, 11, 12, 15]
      ],
      [
        [1, 6, 2, 3],
        [14, 11, 7, 8],
        [4, 9, 13, 10],
        [5, 0, 12, 15]
      ],
    ];
    ordemNumerosEscolhida = ordemNumerosTotal[Random().nextInt(10)];
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
                "Nível 2 (4x4)",
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
    int tamanhoGrid = 4;
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
                if (x != 3 && ordemNumerosEscolhida[x + 1][y] == 0) {
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
                if (y != 3 && ordemNumerosEscolhida[x][y + 1] == 0) {
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
                    fontSize: 50,
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
      corCorrespondente = Colors.lightBlue;
    }
    if (valorBloco == 3 && coordX == 0 && coordY == 2) {
      corCorrespondente = Colors.yellow;
    }
    if (valorBloco == 4 && coordX == 0 && coordY == 3) {
      corCorrespondente = Colors.orange;
    }
    if (valorBloco == 5 && coordX == 1 && coordY == 0) {
      corCorrespondente = Colors.lime;
    }
    if (valorBloco == 6 && coordX == 1 && coordY == 1) {
      corCorrespondente = Colors.brown;
    }
    if (valorBloco == 7 && coordX == 1 && coordY == 2) {
      corCorrespondente = Colors.purple;
    }
    if (valorBloco == 8 && coordX == 1 && coordY == 3) {
      corCorrespondente = Colors.green;
    }
    if (valorBloco == 9 && coordX == 2 && coordY == 0) {
      corCorrespondente = Colors.tealAccent;
    }
    if (valorBloco == 10 && coordX == 2 && coordY == 1) {
      corCorrespondente = Colors.teal;
    }
    if (valorBloco == 11 && coordX == 2 && coordY == 2) {
      corCorrespondente = Colors.orangeAccent;
    }
    if (valorBloco == 12 && coordX == 2 && coordY == 3) {
      corCorrespondente = Colors.lightBlueAccent;
    }
    if (valorBloco == 13 && coordX == 3 && coordY == 0) {
      corCorrespondente = Colors.pink;
    }
    if (valorBloco == 14 && coordX == 3 && coordY == 1) {
      corCorrespondente = Colors.amber;
    }
    if (valorBloco == 15 && coordX == 3 && coordY == 2) {
      corCorrespondente = Colors.grey;
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
        .updateData({'jogo3_nivel2': true});
  }

  void checarVitoria() {
    if (ordemNumerosEscolhida[0][0] == 1) {
      if (ordemNumerosEscolhida[0][1] == 2) {
        if (ordemNumerosEscolhida[0][2] == 3) {
          if (ordemNumerosEscolhida[0][3] == 4) {
            if (ordemNumerosEscolhida[1][0] == 5) {
              if (ordemNumerosEscolhida[1][1] == 6) {
                if (ordemNumerosEscolhida[1][2] == 7) {
                  if (ordemNumerosEscolhida[1][3] == 8) {
                    if (ordemNumerosEscolhida[2][0] == 9) {
                      if (ordemNumerosEscolhida[2][1] == 10) {
                        if (ordemNumerosEscolhida[2][2] == 11) {
                          if (ordemNumerosEscolhida[2][3] == 12) {
                            if (ordemNumerosEscolhida[3][0] == 13) {
                              if (ordemNumerosEscolhida[3][1] == 14) {
                                if (ordemNumerosEscolhida[3][2] == 15) {
                                  if (ordemNumerosEscolhida[3][3] == 0) {
                                    cronometro.stop();
                                    atualizarProgresso();
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            OrdenarNumerosDialog(
                                              tempo: valorCheckbox == false ? textoCronometro : "",
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
    return null;
  }
}
