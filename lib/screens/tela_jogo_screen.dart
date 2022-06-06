import 'dart:async';

import 'package:atipico_game/components/game_session.dart';
import 'package:atipico_game/components/gradient_text.dart';
import 'package:atipico_game/components/image_retriever.dart';
import 'package:atipico_game/screens/game_over_screen.dart';
import 'package:flutter/material.dart';

class TelaJogoScreen extends StatefulWidget {
  int dificuldadeSelecionada;

  TelaJogoScreen({required this.dificuldadeSelecionada, Key? key})
      : super(key: key);

  late GameSession gameSession = GameSession(dificuldadeSelecionada);

  @override
  State<TelaJogoScreen> createState() => _TelaJogoScreenState();
}

class _TelaJogoScreenState extends State<TelaJogoScreen> {
  // Temporizador do game
  Timer? temporizadorJogo;
  int tempoReferenciaTotalJogo = 15000;
  int tempoTotalJogoMilissegundos = 15000;
  int countDownMilissegundos = 15000;
  int bonusTempoRound = 2000;

  // Mensagens ao jogador
  bool messagePlayerVisibility = false;
  String messagePlayer = "";

  // Sessão de jogo, dificuldade, imagens e posições:
  late int dificuldadeSessaoJogo = widget.dificuldadeSelecionada;
  late List<int> dimensoesMatriz = widget.gameSession.fornecerDimensoesMatriz();
  late List<int> localImagemAlt = widget.gameSession.fornecerPosImgAlt();
  late Map<String, Image> imagensFornecidas =
      ImageRetriever.fornecerImagens(dificuldadeSessaoJogo);

  void initState() {
    super.initState();

    temporizadorJogo = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (countDownMilissegundos == 0) {
        timer.cancel();
        invokeGameOver();
      } else {
        setState(() {
          countDownMilissegundos -= 10;
          widget.gameSession.tempoSobrevivido += 10;
        });
      }
    });
  }

  @override
  void dispose() {
    temporizadorJogo?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: GradientText(
                'Selecione a imagem... Atípica!',
                style: TextStyle(fontFamily: 'Lobster', fontSize: 28.0),
                gradient: RadialGradient(colors: <Color>[
                  Color(0xfffed400),
                  Color(0xffff9900),
                ]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: generateImageMatrix(
                dificuldadeSessaoJogo,
                dimensoesMatriz,
                localImagemAlt,
                imagensFornecidas,
                screenHeight,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              child: Column(
                children: <Widget>[
                  buildTextoFeedbackJogador(),
                  buildComboTextWidget(),
                  buildTextoIncentivoJogador(),
                  Container(
                    height: 25,
                    child: Slider(
                      value: countDownMilissegundos.toDouble(),
                      onChanged: (value) {},
                      min: 0,
                      max: tempoTotalJogoMilissegundos.toDouble(),
                    ),
                  ),
                  buildWidgetTentativasRestantes(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Score: ' + widget.gameSession.score.toString(),
                      style: TextStyle(
                          fontFamily: 'Farro',
                          color: Colors.amberAccent,
                          fontSize: 32.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  generateImageMatrix(
    int dificuldadeSessaoJogo,
    List<int> dimensoesMatriz,
    List<int> localImagemAlt,
    Map<String, Image> imagensFornecidas,
      double screenHeight,
  ) {
    Image imagemPadrao = imagensFornecidas["imagemPadrao"]!;
    Image imagemAlt = imagensFornecidas["imagemAlt"]!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
      child: Container(
        constraints: BoxConstraints(maxWidth: screenHeight * 0.45),
        child: GridView.builder(
          itemCount: dimensoesMatriz[0] * dimensoesMatriz[1],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: dimensoesMatriz[1]),
          itemBuilder: (_, int index) {
            if (index + 1 ==
                (((localImagemAlt[0] - 1) * dimensoesMatriz[1]) +
                    localImagemAlt[1])) {
              return InkWell(
                onTap: () {
                  invokeAcerto();
                },
                child: Container(
                  child: imagemAlt,
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  invokeErro();
                },
                child: Container(
                  child: imagemPadrao,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void invokeErro() {
    widget.gameSession.numeroErros++;
    widget.gameSession.comboChain = 0;
    widget.gameSession.tentativasRestantes--;

    if (widget.gameSession.tentativasRestantes == 0) {
      invokeGameOver();
    } else {
      setState(() {
        invokeNewRound();
      });
    }
  }

  void invokeAcerto() {
    setState(() {
      widget.gameSession.numeroAcertos++;
      widget.gameSession.dificuldade++;
      widget.gameSession.score += widget.gameSession.dificuldade *
          10 *
          (widget.gameSession.comboChain <= 2
                  ? 1
                  : widget.gameSession.comboChain.toDouble() / 2.5)
              .toInt();
      widget.gameSession.comboChain++;

      incrementTimer();

      invokeNewRound();
    });
  }

  void incrementTimer() {
    countDownMilissegundos += bonusTempoRound;

    if (countDownMilissegundos > tempoTotalJogoMilissegundos) {
      tempoTotalJogoMilissegundos = countDownMilissegundos;
    } else {
      if (tempoTotalJogoMilissegundos > tempoReferenciaTotalJogo &&
          countDownMilissegundos < tempoReferenciaTotalJogo) {
        tempoTotalJogoMilissegundos = tempoReferenciaTotalJogo;
      }
    }
  }

  void invokeNewRound() {
    dificuldadeSessaoJogo = widget.gameSession.dificuldade;
    dimensoesMatriz = widget.gameSession.fornecerDimensoesMatriz();
    localImagemAlt = widget.gameSession.fornecerPosImgAlt();
    imagensFornecidas = ImageRetriever.fornecerImagens(dificuldadeSessaoJogo);
    widget.gameSession.roundCount++;
  }

  void invokeGameOver() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GameOverScreen(
                  gameSession: widget.gameSession,
                )));
  }

  Widget buildWidgetTentativasRestantes() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: () {
        List<Widget> indicadorTentativasRestantes = [];

        for (int i = 0; i < widget.gameSession.tentativasRestantes; i++) {
          indicadorTentativasRestantes.add(Container(
            child: const Icon(
              Icons.favorite_rounded,
              color: Colors.red,
              size: 32.0,
            ),
          ));
        }

        return indicadorTentativasRestantes;
      }(),
    );
  }

  Widget buildTextoFeedbackJogador() {
    return Visibility(
      visible: (widget.gameSession.roundCount > 0),
      child: () {
        if (widget.gameSession.comboChain > 0) {
          return GradientText(
            'Acertou!',
            style: TextStyle(fontFamily: 'Lobster', fontSize: 32.0),
            gradient: RadialGradient(colors: <Color>[
              Color(0xfffed400),
              Color(0xffff9900),
            ]),
          );
        } else {
          return GradientText(
            'Errou...',
            style: TextStyle(fontFamily: 'Lobster', fontSize: 32.0),
            gradient: RadialGradient(colors: <Color>[
              Color(0xfffed400),
              Color(0xffff9900),
            ]),
          );
        }
      }(),
    );
  }

  Widget buildComboTextWidget() {
    return Visibility(
      visible: (widget.gameSession.comboChain > 1),
      child: Text(
        'Combo: ' + widget.gameSession.comboChain.toString() + " x",
        style: TextStyle(
            fontFamily: 'Farro', color: Colors.amberAccent, fontSize: 24.0),
      ),
    );
  }

  Widget buildTextoIncentivoJogador() {
    String textoIncentivo = () {
      if (widget.gameSession.comboChain == 2) {
        return "Vamos lá! Aquecendo.";
      } else if (widget.gameSession.comboChain == 3) {
        return "Isso aí!";
      } else if (widget.gameSession.comboChain == 4) {
        return "Mandou bem!";
      } else if (widget.gameSession.comboChain == 5) {
        return "Uauuu!";
      } else if (widget.gameSession.comboChain == 6) {
        return "Top!";
      } else if (widget.gameSession.comboChain == 7) {
        return "Você está demais!";
      } else if (widget.gameSession.comboChain == 8) {
        return "Você é experto!";
      } else if (widget.gameSession.comboChain == 9) {
        return "Aí já é profissa!";
      } else if (widget.gameSession.comboChain == 10) {
        return "Caraaaaca!";
      } else {
        return "";
      }
    }();

    return Visibility(
      visible: (widget.gameSession.comboChain >= 2),
      child: Text(
        textoIncentivo,
        style: TextStyle(
            fontFamily: 'Farro', color: Colors.amberAccent, fontSize: 24.0),
      ),
    );
  }
}
