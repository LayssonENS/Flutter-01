import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          //Segundo Container parte degrade
          ClipPath(
            clipper: ClipHome(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.7,
              //Degrade e Bordas arredondadas
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [const Color(0xFF4FC8C2), const Color(0xFF95DDD9)],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              alignment: Alignment.topCenter,
              child: ClipPath(
                clipper: ClipHome(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'IMC'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //Terceiro container Parte branca
          Container(
            height: MediaQuery.of(context).size.height / 3,
            padding: EdgeInsets.all(42),
            //Coluna para inserir dados no segundo container
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ClipHome extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 50);

    var pointControl = Offset(size.width / 2.0, size.height + 20);
    var endPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(
        pointControl.dx, pointControl.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
