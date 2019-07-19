import 'package:flutter/material.dart';

class DeathScreen{
  static int highScore;

  RRect deathScreenRRect;
  int score;

  DeathScreen(this.score){
    this.deathScreenRRect = RRect.fromRectAndRadius(Rect.fromLTWH(75,200,275,300),Radius.circular(10));
  }
  void render(Canvas canvas,Paint paint,int coins){

    paint.color = Colors.deepPurple;
    canvas.drawRRect(this.deathScreenRRect,paint);

    paint.color = Colors.deepPurpleAccent;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(125,400,175,40),Radius.circular(2)),paint);

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(125,350,75,40),Radius.circular(2)),paint);

    int highScore = DeathScreen.highScore;

    TextSpan scoreSpan = new TextSpan(style: new TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold), text: 'Score: $score');
    TextSpan highScoreSpan = new TextSpan(style: new TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold), text: 'High Score: $highScore');
    TextSpan restartSpan = new TextSpan(style: new TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold), text: 'Play Again');
    TextSpan shopSpan = new TextSpan(style: new TextStyle(color: Colors.white,fontSize:20,fontWeight:FontWeight.bold), text: 'Shop');

    TextPainter tp = new TextPainter(text: scoreSpan, textAlign: TextAlign.left);
    TextPainter tp2 = new TextPainter(text: highScoreSpan, textAlign: TextAlign.left);
    TextPainter tp3 = new TextPainter(text: restartSpan, textAlign: TextAlign.left);
    TextPainter tp4 = new TextPainter(text: shopSpan, textAlign: TextAlign.left);


    tp.textDirection = TextDirection.ltr;
    tp.layout();
    tp.paint(canvas, new Offset(125, 250));

    tp2.textDirection = TextDirection.ltr;
    tp2.layout();
    tp2.paint(canvas, new Offset(125, 280));

    tp3.textDirection = TextDirection.ltr;
    tp3.layout();
    tp3.paint(canvas, new Offset(165, 408));

    tp4.textDirection = TextDirection.ltr;
    tp4.layout();
    tp4.paint(canvas, new Offset(140, 358));

  }

}