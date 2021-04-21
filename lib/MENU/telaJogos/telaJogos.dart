import 'package:flutter/material.dart';
import 'data.dart';
import 'intro_page_item.dart';
import 'page_transformer.dart';
import '../../DADOS/carregamentoImagens/carregamentoImagens.dart';

class TelaJogos extends StatefulWidget {
  @override
  TelaJogosState createState() => new TelaJogosState();
}

class TelaJogosState extends State<TelaJogos> {
  Image fundoJogos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(22, 12, 127, 1.0),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Imagens.fundoJogos.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Opacity(
                opacity: 1.0,
                child: Center(
                  child: FractionallySizedBox(
                    heightFactor: 0.8,
                    child: PageTransformer(
                      pageViewBuilder: (context, visibilityResolver) {
                        return PageView.builder(
                          controller: PageController(viewportFraction: 0.85),
                          itemCount: sampleItems.length,
                          itemBuilder: (context, index) {
                            final item = sampleItems[index];
                            final pageVisibility =
                                visibilityResolver.resolvePageVisibility(index);
                            return IntroPageItem(
                              item: item,
                              pageVisibility: pageVisibility,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
