import 'package:flutter/material.dart';
import 'package:universo_logico/JOGOS/jogoMemorizarCores/memorizarCores.dart';
import 'package:universo_logico/JOGOS/jogoOrdenarNumeros/niveis/ordenarNumeros2.dart';
import 'package:universo_logico/JOGOS/jogoOrdenarNumeros/niveis/ordenarNumeros3.dart';
import 'package:universo_logico/JOGOS/jogoOrdenarNumeros/selecaoNiveis.dart';
import 'package:universo_logico/JOGOS/jogoSomarNumeros/somarNumeros.dart';
import 'package:universo_logico/JOGOS/jogoVelha/jogoDaVelha.dart';
import 'package:universo_logico/MENU/telaIntroducao/telaIntroducao.dart';
import 'JOGOS/jogoOrdenarNumeros/niveis/ordenarNumeros1.dart';
import 'MENU/telaJogos/telaJogos.dart';
import 'MENU/telaInicio/telaInicio.dart';
import 'JOGOS/jogoPar&Impar/par&Impar.dart';
import 'MENU/telaLogin/login.dart';

void main()
{
  runApp(new MaterialApp(
    home: new Aplicativo(),
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>
    {
      //TELA DE INTRODUÇÃO
      '/telaIntroducao': (_) => new TelaIntroducao(),
      //TELA DE LOGIN
      '/telaLogin': (_) => new Login(),
      //TELA DE JOGOS
      '/telaJogos': (_) => new TelaJogos(),
      //PAR E ÍMPAR
      '/par&Impar': (_) => new ParImpar(),
      //JOGO DA VELHA
      '/jogoDaVelha': (_) => new JogoDaVelha(),
      //ORDENAR NÚMEROS
      '/selecaoOrdenarNumeros': (_) => new SelecaoOrdenarNumeros(),
      '/ordenarNumeros1': (_) => new OrdenarNumerosNivel1(),
      '/ordenarNumeros2': (_) => new OrdenarNumerosNivel2(),
      '/ordenarNumeros3': (_) => new OrdenarNumerosNivel3(),
      //MEMORIZAR CORES
      '/memorizarCores': (_) => new MemorizarCores(),
      //SOMAR NÚMEROS
      '/somarNumeros': (_) => new SomarNumeros(),
    }
  ));
}

class Aplicativo extends StatefulWidget
{
  @override
  AplicativoState createState() => new AplicativoState();
}

class AplicativoState extends State<Aplicativo>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: TelaInicio(), 
    );
  }
}