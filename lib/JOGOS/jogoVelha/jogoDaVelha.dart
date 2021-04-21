import 'package:flutter/material.dart';
import 'package:universo_logico/DADOS/caixasDialogos/dialogoJogoVelha.dart';

class JogoDaVelha extends StatefulWidget {
  @override
  JogoDaVelhaState createState() => JogoDaVelhaState();
}

class Botao{
  final id;
  String texto;
  Color bg;
  bool pressionado;

  Botao({this.id, this.texto="", this.bg = Colors.grey, this.pressionado = true});
}

class JogoDaVelhaState extends State<JogoDaVelha> {
  List<Botao> buttonsList;
  var jogador1;
  var jogador2;
  var jogadorAtivo;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<Botao> doInit() {
    jogador1 = new List();
    jogador2 = new List();
    jogadorAtivo = 1;

    var gameButtons = <Botao>[
      new Botao(id: 1),
      new Botao(id: 2),
      new Botao(id: 3),
      new Botao(id: 4),
      new Botao(id: 5),
      new Botao(id: 6),
      new Botao(id: 7),
      new Botao(id: 8),
      new Botao(id: 9),
    ];
    return gameButtons;
  }

  void playGame(Botao gb) {
    setState(() {
      if (jogadorAtivo == 1) {
        gb.texto = "X";
        gb.bg = Colors.red;
        jogadorAtivo = 2;
        jogador1.add(gb.id);
      } else {
        gb.texto = "O";
        gb.bg = Colors.black;
        jogadorAtivo = 1;
        jogador2.add(gb.id);
      }
      gb.pressionado = false;
      int vencedor = checkVencedor();
      if (vencedor == -1) {
        if (buttonsList.every((p) => p.texto != "")) {
          showDialog(barrierDismissible: false, context: context, builder: (_) => new JogoVelhaDialog(resultado: "Deu Velha!",));
          resetarJogo();
        }
        /*else{
         jogadorAtivo == 2 ? autoPlay(): true;
       }*/
      }
    });
  }

  /*void autoPlay(){
    var lugaresVazios = new List();
    var list = new List.generate(9, (i) => i + 1);

    for (var lugarID in list) {
      if((jogador1.contains(lugarID) || jogador2.contains(lugarID))){
        lugaresVazios.add(lugarID);
      }
      
    }
  
      var r = new Random();
      var randIndex = r.nextInt(lugaresVazios.length-1);
      var lugarID = lugaresVazios[randIndex];
      int i = buttonsList.indexWhere((p)=> p.id == lugarID);
      playGame(buttonsList[i]);
  }*/

  int checkVencedor() {
    var vencedor = -1;
    // linha 1
    if (jogador1.contains(1) && jogador1.contains(2) && jogador1.contains(3)) {
      vencedor = 1;
    }
    if (jogador2.contains(1) && jogador2.contains(2) && jogador2.contains(3)) {
      vencedor = 2;
    }
    // linha 2
    if (jogador1.contains(4) && jogador1.contains(5) && jogador1.contains(6)) {
      vencedor = 1;
    }
    if (jogador2.contains(4) && jogador2.contains(5) && jogador2.contains(6)) {
      vencedor = 2;
    }
    // linha 3
    if (jogador1.contains(7) && jogador1.contains(8) && jogador1.contains(9)) {
      vencedor = 1;
    }
    if (jogador2.contains(7) && jogador2.contains(8) && jogador2.contains(9)) {
      vencedor = 2;
    }
    // coluna 1
    if (jogador1.contains(1) && jogador1.contains(4) && jogador1.contains(7)) {
      vencedor = 1;
    }
    if (jogador2.contains(1) && jogador2.contains(4) && jogador2.contains(7)) {
      vencedor = 2;
    }
    // coluna 2
    if (jogador1.contains(2) && jogador1.contains(5) && jogador1.contains(8)) {
      vencedor = 1;
    }
    if (jogador2.contains(2) && jogador2.contains(5) && jogador2.contains(8)) {
      vencedor = 2;
    }
    // coluna 3
    if (jogador1.contains(3) && jogador1.contains(6) && jogador1.contains(9)) {
      vencedor = 1;
    }
    if (jogador2.contains(3) && jogador2.contains(6) && jogador2.contains(9)) {
      vencedor = 2;
    }

    //diagonal
    if (jogador1.contains(1) && jogador1.contains(5) && jogador1.contains(9)) {
      vencedor = 1;
    }
    if (jogador2.contains(1) && jogador2.contains(5) && jogador2.contains(9)) {
      vencedor = 2;
    }

    if (jogador1.contains(3) && jogador1.contains(5) && jogador1.contains(7)) {
      vencedor = 1;
    }
    if (jogador2.contains(3) && jogador2.contains(5) && jogador2.contains(7)) {
      vencedor = 2;
    }

    if (vencedor != -1) {
      if (vencedor == 1) {
        showDialog(barrierDismissible: false, context: context, builder: (_) => new JogoVelhaDialog(resultado: "Jogador 1 venceu!",));
        resetarJogo();
      } else {
        showDialog(barrierDismissible: false ,context: context, builder: (_) => new JogoVelhaDialog(resultado: "Jogador 2 venceu!",));
        resetarJogo();
      }
    }
    return vencedor;
  }

  void resetarJogo() {
    if (Navigator.canPop(context)) Navigator.canPop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        context, '/telaJogos', (Route<dynamic> route) => false);
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
                  "Jogo da Velha",
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
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10.0),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 9.0),
            itemCount: buttonsList.length,
            itemBuilder: (context, i) => new SizedBox(
              width: 100.0,
              height: 100.0,
              child: new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(8.0),
                onPressed: buttonsList[i].pressionado
                    ? () => playGame(buttonsList[i])
                    : null,
                child: new Text(buttonsList[i].texto,
                    style: new TextStyle(color: Colors.white, fontSize: 60.0)),
                color: buttonsList[i].bg,
                disabledColor: buttonsList[i].bg,
              ),
            ),
          ),
          RaisedButton(
            child: new Text(
              "Resetar",
              style: new TextStyle(
                  color: Colors.white, fontSize: 22.0, fontFamily: 'LemonMilk'),
            ),
            color: Colors.red,
            padding: const EdgeInsets.all(20.0),
            onPressed: resetarJogo,
          ),
        ],
      )),
    );
  }
}
