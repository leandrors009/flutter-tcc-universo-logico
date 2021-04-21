import 'package:flutter/material.dart';
import 'package:universo_logico/DADOS/carregamentoImagens/carregamentoImagens.dart';

class IntroItem {
  IntroItem({
    this.title,
    this.category,
    this.imageGame,
    this.buttonText,
    this.urlButton,
    this.itemColor,
  });

  final String title;
  final String category;
  final Image imageGame;
  final String buttonText;
  final String urlButton;
  final Color itemColor;
}

final sampleItems = <IntroItem>[
  new IntroItem(title: 'Pense rapidamente e me diga se é par ou ímpar!', category: 'PAR E ÍMPAR', imageGame: Imagens.capaJogoParImpar, buttonText: 'Jogar', urlButton: '/par&Impar', itemColor: Colors.red),
  new IntroItem(title: 'Monte uma sequência para ganhar o jogo!', category: 'JOGO DA VELHA', imageGame: Imagens.capaJogoVelha, buttonText: 'Jogar', urlButton: '/jogoDaVelha', itemColor: Colors.lightBlue),
  new IntroItem(title: 'Ordene os números na sequência correta!', category: 'ORDENAR NÚMEROS', imageGame: Imagens.capaJogoOrdenarNumeros, buttonText: 'Jogar', urlButton: '/selecaoOrdenarNumeros', itemColor: Colors.deepOrange),
  new IntroItem(title: 'Memorize e selecione as cores corretas!', category: 'MEMORIZAR CORES', imageGame: Imagens.capaMemorizarCores, buttonText: 'Jogar', urlButton: '/memorizarCores', itemColor: Colors.deepPurpleAccent),
  new IntroItem(title: 'Some os números para encontrar o valor alvo!', category: 'SOMAR NÚMEROS', imageGame: Imagens.capaJogoParImpar, buttonText: 'Jogar', urlButton: '/somarNumeros', itemColor: Colors.pink),
];