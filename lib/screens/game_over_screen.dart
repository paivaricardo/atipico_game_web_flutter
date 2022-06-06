import 'package:atipico_game/components/game_session.dart';
import 'package:atipico_game/components/gradient_text.dart';
import 'package:atipico_game/screens/dificuldade_screen.dart';
import 'package:atipico_game/screens/intro_screen.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  GameSession gameSession;

  GameOverScreen({required this.gameSession, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameSession.maxScore = gameSession.score;

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
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const GradientText(
                    'Atípico!',
                    style: TextStyle(fontFamily: 'Lobster', fontSize: 92.0),
                    gradient: RadialGradient(colors: <Color>[
                      Color(0xfffed400),
                      Color(0xffff9900),
                    ]),
                  ),
                  const Text('Fim de jogo!', style: TextStyle(fontFamily: 'Farro', color: Colors.amberAccent, fontSize: 32.0),),
                  const Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Text('Sua pontuação:', style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 32.0),),
                  ),
                  Text(gameSession.score.toString(), style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 32.0),),
                  const Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Text('Pontuação mais alta:', style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 32.0),),
                  ),
                  Text(GameSession.maxScore.toString(), style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 32.0),),
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text('Número de acertos:', style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 24.0),),
                  ),
                  Text(gameSession.numeroAcertos.toString(), style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 24.0),),
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text('Número de erros:', style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 24.0),),
                  ),
                  Text(gameSession.numeroErros.toString(), style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 24.0),),
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text('Tempo sobrevivido:', style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 24.0),),
                  ),
                  Text((gameSession.tempoSobrevivido / 1000).toString() + ' segundos', style: TextStyle(fontFamily: 'Lobster', color: Colors.amberAccent, fontSize: 24.0),),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DificuldadeScreen()));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          minimumSize: MaterialStateProperty.all(const Size(250, 60)),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                          MaterialStateProperty.all(Colors.black12),
                        ),
                        child: const Text(
                          'Jogar novamente',
                          style: TextStyle(fontSize: 32.0, color: Colors.black87),
                        ),
                      ),
                    ),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => IntroScreen()));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          minimumSize: MaterialStateProperty.all(const Size(250, 60)),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                          MaterialStateProperty.all(Colors.black12),
                        ),
                        child: const Text(
                          'Retornar ao início',
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
                onPressed: () { },
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
