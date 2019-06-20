import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: FlipperWidget(),
    );
  }
}

class FlipperWidget extends StatefulWidget {
  @override
  _FlipperWidgetState createState() => _FlipperWidgetState();
}

class _FlipperWidgetState extends State<FlipperWidget> with SingleTickerProviderStateMixin {

  bool reversed = false;
  Animation<double> animation;
  AnimationController animationController;


  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10)
    );

    animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: -pi/2
        ),
        weight: 0.5
      ),
      TweenSequenceItem(
          tween: Tween(
              begin: pi/2,
              end: 0.0
          ),
          weight: 0.5
      ),
    ]).animate(animationController);
  }


  @override
  void dispose() {
    super.dispose();
  }

  doAnimation(){
    if(!mounted) return;
    if(reversed){
      animationController.reverse();
      reversed = false;
    } else {
      animationController.forward();
      reversed = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flipper Widget", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black87,
        child: Center(
          child: AnimatedBuilder(animation: animation, builder: (context, child){
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(animation.value),
              child: GestureDetector(
                onTap: doAnimation,
                child: IndexedStack(
                  children: <Widget>[
                    CardOne(),
                    CardTwo()
                  ],
                  alignment: Alignment.center,
                  index: animationController.value < 0.5 ? 0: 1,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class CardOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[500],
      child: Container(
        width: 300,
        height: 300,
        child: Center(
          child: Text("What did one wall say to the other wall?", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}

class CardTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[900],
      child: Container(
        width: 300,
        height: 300,
        child: Center(
          child: Text("I’ll meet you at the corner hahahahahahaha", style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 30.0
          ),
          textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}

