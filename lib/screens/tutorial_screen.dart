import 'package:atipico_game/components/gradient_text.dart';
import 'package:atipico_game/screens/tela_jogo_screen.dart';
import 'package:flutter/material.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: screenWidth,
            child: Image.asset(
              'assets/img/fundo_atpc.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints(maxWidth: screenWidth * 0.8),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const GradientText(
                    'Tutorial',
                    style: TextStyle(fontFamily: 'Lobster', fontSize: 92.0),
                    gradient: RadialGradient(colors: <Color>[
                      Color(0xfffed400),
                      Color(0xffff9900),
                    ]),
                  ),
                  const Text(
                    "Jogar o jogo é extremamente simples!",
                    style: TextStyle(fontFamily: 'Farro', fontSize: 24.0, color: Colors.white),
                  ),
                  const Text(
                    "Você deve selecionar uma única imagem que se distingue das demais apresentadas na tela.",
                    style: TextStyle(fontFamily: 'Farro', fontSize: 24.0, color: Colors.white),
                  ),
                  const Text(
                    "Você possui um tempo limitado para selecionar a imagem.",
                    style: TextStyle(fontFamily: 'Farro', fontSize: 24.0, color: Colors.white),
                  ),
                  const Text(
                    "Sequências de imagens corretas selecionadas podem render-lhe pontos adicionais!",
                    style: TextStyle(fontFamily: 'Farro', fontSize: 24.0, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 5),
                              blurRadius: 7.5),
                        ],
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color(0xffffdd2a),
                            Color(0xffe68902),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                          minimumSize:
                              MaterialStateProperty.all(const Size(250, 60)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor: MaterialStateProperty.all(Colors.black12),
                        ),
                        child: const Text(
                          'Retornar',
                          style: TextStyle(fontSize: 32.0, color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.volume_up_rounded,
                  color: Colors.amber,
                ),
                onPressed: () {},
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(
                  Icons.settings_rounded,
                  color: Colors.amber,
                ),
                onPressed: () {},
              )),
        ],
      ),
    );
  }
}
