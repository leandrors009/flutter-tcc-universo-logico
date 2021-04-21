import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universo_logico/DADOS/carregamentoImagens/carregamentoImagens.dart';
import 'package:universo_logico/DADOS/variaveisEstaticas.dart';

void main() {
  runApp(new MaterialApp(
    home: new SelecaoOrdenarNumeros(),
    debugShowCheckedModeBanner: false,
  ));
}

class Niveis {
  final int numeroNivel;
  final String nomeNivel;
  final String enderecoNivel;

  Niveis({
    this.numeroNivel,
    this.nomeNivel,
    this.enderecoNivel,
  });
}

class SelecaoOrdenarNumeros extends StatefulWidget {
  @override
  SelecaoOrdenarNumerosState createState() => new SelecaoOrdenarNumerosState();
}

class SelecaoOrdenarNumerosState extends State<SelecaoOrdenarNumeros> {
  List<String> valoresBD = ["jogo3_nivel1", "jogo3_nivel2", "jogo3_nivel3"];
  List<String> valoresNivel = ["1", "2", "3"];
  List<String> valoresNavigator = [
    "/ordenarNumeros1",
    "/ordenarNumeros2",
    "/ordenarNumeros3"
  ];
  List<String> valoresTitulo = [
    "Nível 1 (3x3)",
    "Nível 2 (4x4)",
    "Nível 3 (5x5)"
  ];
  bool valorCheckbox = false;

  double valoresPadding(String valorNivel) {
    if (valorNivel.contains("1")) {
      return 27.0;
    }
    if (valorNivel.contains("2")) {
      return 24.0;
    }
    if (valorNivel.contains("3")) {
      return 25.0;
    } else {
      return 0;
    }
  }

  Future atualizarProgresso() async {
    var emailUsuario;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailUsuario = prefs.getString('email');
    final bd = Firestore.instance;
    DocumentSnapshot qn =
        await bd.collection("progresso").document("$emailUsuario").get();
    return qn;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, '/telaJogos', (Route<dynamic> route) => false);
        return false;
      },
      child: Container(
          color: Color.fromRGBO(22, 12, 127, 1.0),
          child: SafeArea(
            child: Scaffold(
              body: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Imagens.fundoSelecaoOrdenarNumeros.image,
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
                              "Ordenar Números",
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
                      Expanded(
                        flex: 24,
                        child: FutureBuilder(
                          future: atualizarProgresso(),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.yellow,
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: valoresBD.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, valoresNavigator[index]);
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 10,
                                            right: 10,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 15,
                                                  top: 15,
                                                  left: valoresPadding(
                                                      valoresNivel[index]),
                                                  right: valoresPadding(
                                                      valoresNivel[index])),
                                              child: Text(
                                                valoresNivel[index],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'LemonMilk',
                                                    fontSize: 20),
                                              ),
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  new BoxShadow(
                                                    blurRadius: 3.0,
                                                    color: Colors.black,
                                                    offset:
                                                        new Offset(1.0, 1.0),
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.deepPurple,
                                              ),
                                            ),
                                            Container(
                                              child: Text(valoresTitulo[index],
                                                  style: TextStyle(
                                                      fontFamily: 'Aller',
                                                      fontSize: 20)),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: snapshot.data[
                                                          valoresBD[index]] ==
                                                      false
                                                  ? Colors.black
                                                  : Colors.yellow,
                                              size: 55,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Deseja jogar com cronômetro:",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'AntiPastoPro',
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (VariaveisEstaticas.checkBoxCronometro == false) {
                                      VariaveisEstaticas.checkBoxCronometro = true;
                                    } else {
                                      VariaveisEstaticas.checkBoxCronometro = false;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Icon(
                                    VariaveisEstaticas.checkBoxCronometro == true
                                        ? Icons.check_box_outline_blank
                                        : Icons.check_box,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
