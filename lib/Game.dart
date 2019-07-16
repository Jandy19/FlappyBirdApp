import 'package:flame/game.dart';
import 'dart:ui';
import 'dart:math';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flappy_bird/Bird.dart';
import 'package:flutter/gestures.dart';
import 'package:flappy_bird/Pipe.dart';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';

class bGame extends Game {
  Size screenSize;
  Bird b = Bird(650);
  var pipes = [];
  var lost = false;
  var start = false;
  var score=0;
  Sprite sprite;
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
    Rect background = Rect.fromLTRB(0,0,461,700);
    Paint paint = Paint();
    paint.color = Colors.black;
    canvas.drawRect(background,paint);
    paint.color = Colors.blue;
    b.render(canvas);
    for (Pipe x in pipes){
      Rect rect = Rect.fromLTRB(x.getX(),0,x.getX()+x.width,x.getY1());
      Rect rect2 = Rect.fromLTRB(x.getX(),x.getY2(),x.getX()+x.width,775);
      paint.color = Colors.green;
      canvas.drawRect(rect,paint);
      canvas.drawRect(rect2,paint);
    }
      TextSpan span = new TextSpan(style: new TextStyle(color: Colors.white,fontSize:30), text: '$score');
      TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left);
      tp.textDirection=TextDirection.ltr;
      tp.layout();
      tp.paint(canvas, new Offset(200, 30));
    score =0;
    for(Pipe x in pipes){
      if(x.getX()>40 &&x.getX()<80){
        if(x.getY1()>b.getY()+25 || x.getY2()<b.getY()-25) {
          lost = true;
        }
      }
      if(x.getX()<20){
        score+=1;
      }
    }
    }
    if(lost==true){
      TextSpan span = new TextSpan(style: new TextStyle(color: Colors.white,fontSize:30), text: '$score');
      TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left);
      tp.textDirection=TextDirection.ltr;
      tp.layout();
      tp.paint(canvas, new Offset(200, 30));

    }
  }
  void update(double t){
    if(start==true){
    if(b.getY()<660) {
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
    super.resize(size);

  }
  void onTapDown(TapDownDetails d){
    if(start==false){
      start=true;
    }else{
    if(b.getY()>15){
    b.moveUp();
    }
    if(lost==true){
      lost =false;
      start =false;
      b.y=300;
      pipes = [];
    }}
  }
}