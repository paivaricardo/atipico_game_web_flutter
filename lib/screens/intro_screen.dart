import 'package:atipico_game/components/gradient_text.dart';
import 'package:atipico_game/screens/creditos_screen.dart';
import 'package:atipico_game/screens/dificuldade_screen.dart';
import 'package:atipico_game/screens/tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

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
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GradientText(
                  'Atípico!',
                  style: TextStyle(fontFamily: 'Lobster', fontSize: 92.0),
                  gradient: RadialGradient(colors: <Color>[
                    Color(0xfffed400),
                    Color(0xffff9900),
                  ]),
                ),
                const Text("Versão: 1.0.1", style: TextStyle(fontFamily: 'Farro', fontSize: 24.0, color: Colors.white),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 400.0),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 5),
                          blurRadius: 7.5),
                    ],
                    gradient: LinearGradient(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DificuldadeScreen()));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      minimumSize: MaterialStateProperty.all(Size(250, 60)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor: MaterialStateProperty.all(Colors.black12),
                    ),
                    child: Text(
                      'Jogar!',
                      style: TextStyle(fontSize: 32.0, color: Colors.black87),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TutorialScreen()));
                    },
                    child: Text(
                      'Tutorial',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: 'Lobster',
                          color: Colors.amber),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreditosScreen()));
                      },
                      child: Text(
                        'Créditos',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'Lobster',
                            color: Colors.amber),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextButton(
                      onPressed: () {
                        html.window.open("https://forms.gle/254VbtvXBDQACw2FA", "_blank");
                      },
                      child: Text(
                        'Feedback',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'Lobster',
                            color: Colors.amber),
                      )),
                ),
              ],
            )),
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
