
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(SomarNumeros());

class SomarNumeros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SomarNumerosPage(title: 'Jogo dos Numeros'),
    );
  }
}

   int valorAleatorioa;


class SomarNumerosPage extends StatefulWidget {
  SomarNumerosPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SomarNumerosPageState createState() => SomarNumerosPageState();
}
class SomarNumerosPageState extends State<SomarNumerosPage> {

  Comum comum;

  @override
  void initState(){
    super.initState();
    valorAleatorioa = criarValorAlvo();
  }


   static int criarValorAlvo() {
    int valorAleatorio;
    var random = new Random();
    valorAleatorio = 4 + random.nextInt(25 - 4);

    return valorAleatorio;
  }

  //Construir bloco que mostra o número alvo
  Container construirNumeroAlvo({String title, int valorAlvo}) {
    return Container(
      width: 280,
      height: 120,
      alignment: Alignment(0.0, 0.0),
      child: Column(
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.black)),
          SizedBox(
            height: 20,
          ),
          Text(
            valorAlvo.toString(),
            style: TextStyle(
                color: Colors.black87,
                fontSize: 50,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: new BorderRadius.circular(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.topCenter,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                construirNumeroAlvo(
                  title: 'Alvo',
                  valorAlvo: valorAleatorioa,
                ),
                construirBlocos(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container construirBlocos() {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey,
                    border: Border.all(width: 1.0)
                  ),
                  child: Align(
                    child: Text(
                      '4',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.red,
                      border: Border.all(width: 1.0)),
                  child: Align(
                    child: Text(
                      '10',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                      border: Border.all(width: 1.0)),
                  child: Align(
                    child: Text(
                      '5',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green,
                      border: Border.all(width: 1.0)),
                  child: Align(
                    child: Text(
                      '15',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.purple,
                      border: Border.all(width: 1.0)),
                  child: Align(
                    child: Text(
                      '8',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.orange,
                      border: Border.all(width: 1.0)),
                  child: Align(
                    child: Text(
                      '1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }

}

class Comum {

  static final List<Color> list = [
    Colors.blue,
    Colors.pink,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.brown,
  ];
   int valorAleatorio = valorAleatorioa;

  static List<List> combo = [];

  static int pegarNumeroAleatorio({int min, int max}) {
    if (min == max) {
      return min;
    }
    Random random = Random();
    return min + random.nextInt(max - min);
  }

  static Color pegarCorAleatoria() {
    return list[Comum.pegarNumeroAleatorio(min: 0, max: list.length)];
  }

  static encontrarCombinacao(int value, int length) {
    List<int> combinacoes = [];
    int restante = value;

    bool looper = false;
    int counter = 0;

    while (!looper) {
      int valorAleatorio = (counter == length - 1)
          ? restante
          : pegarNumeroAleatorio(min: 1, max: restante);
      combinacoes.add(valorAleatorio);
      restante -= valorAleatorio;
      counter++;
      if (restante < 0 || restante == 0) {
        looper = true;
      }
    }
    return combinacoes;
  }

  static preencherComValores(List combinacoes, int max, int tamanho) {
    for (var i = 0; i < tamanho; i++) {
      if (combinacoes.length < tamanho) {
        combinacoes.add(pegarNumeroAleatorio(min: 0, max: max));
      }
    }
    combinacoes.shuffle();
    return combinacoes;
  }
  void gerarValores(){
    //List<int> combinacoes = encontrarCombinacao(valorAleatorio, 3);
    //List<int> valorBloco = preencherComValores(combinacoes, valorAleatorio * 2, 6);
  }            
}
