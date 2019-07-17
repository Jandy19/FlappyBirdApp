import 'package:flame/game.dart';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flappy_bird/Bird.dart';
import 'package:flutter/gestures.dart';
import 'package:flappy_bird/Pipe.dart';
import 'Background.dart';
import 'DeathScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bGame extends Game {

  Size screenSize;
  Bird b = Bird(650);
  Background background = Background();
  Paint paint = Paint();

  var pipes = [];
  var lost = false;
  var start = false;
  var score=0;

  void render(Canvas canvas){
    if(lost==false){

    var rng = Random();

    if(rng.nextInt(100)<5) {
      int flag = 1;
      for(Pipe x in pipes){

        if(x.getX()>200){
          flag =0;
        }

      }

      if(flag==1) {
        pipes.add(Pipe());
      }

    }
    Paint paint = Paint();
    paint.color = Colors.blue;

    background.render(canvas);
    b.render(canvas);


    for (Pipe x in pipes){
        x.render(canvas,paint);
    }


    TextSpan span = new TextSpan(style: new TextStyle(color: Colors.white,fontSize:30), text: '$score');
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left);
    tp.textDirection=TextDirection.ltr;
    tp.layout();
    tp.paint(canvas, new Offset(200, 30));

    score =0;
    for(Pipe x in pipes){
      if((x.getX()>50 && x.getX()<93)){
        if(b.getY()<x.getY1() || b.getY()+43>x.getY2()) {
          lost = true;
        }
      }
      if(x.getX()<50){
        score+=1;
      }
    }

    }
    if(lost==true){

      if(score>DeathScreen.highScore){

        setHighScore(score);

      }

      background.render(canvas);
      DeathScreen deathScreen = DeathScreen(score);
      deathScreen.render(canvas,paint);
    }
  }
  void setHighScore(int score) async{

    DeathScreen.highScore = score;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("highScore",score);


  }
  void update(double t){

    if(start==true){

    if(b.getY()<732) {
      b.fall();
    }else{
      lost = true;
    }
    for(Pipe x in pipes){
      x.move();
    }
    }

  }
  void resize(Size size){
    screenSize = size;
    print(size);
    super.resize(size);

  }
  void onTapDown(TapDownDetails d){
    if(start==false){
      start=true;
    }else{
    if(b.getY()>15){
    b.moveUp();
    }
    if(lost==true && (d.globalPosition.dx>125 && d.globalPosition.dx<300 && d.globalPosition.dy>400 && d.globalPosition.dy<440)){
      lost =false;
      start =false;
      b.y=300;
      pipes = [];
    }}
  }
}