import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flame/sprite.dart';
import 'package:flame/animation.dart' as animation;

class Pipe{
  double x,y1,y2;
  var speed = 1.0;
  double width = 40;

  int spacing;

  bool showCoin = true;
  animation.Animation goldCoin;
  int counter = 0;
  Pipe(){

    var rng = new Random();

    this.x=461;

    this.y1=rng.nextDouble()*520;
    int extraSpace = rng.nextInt(60);

    spacing = 120+extraSpace;

    this.y2=this.y1+spacing;

    this.goldCoin = animation.Animation.sequenced('goldCoin.png',5,textureWidth:16.0);
  }
  void move(){
    this.speed+=0.00001;
    this.x-=this.speed;

  }

  double getX(){
    return x;

  }
  double getY1(){
    return y1;

  }
  double getY2(){
    return y2;

  }
  void coinCollected(){
    this.showCoin = false;

  }
  void render(Canvas canvas,Paint paint){

    Rect rect = Rect.fromLTRB(x,0,x+width,y1);
    Rect rect2 = Rect.fromLTRB(x,x,x+width,775);

    paint.color = Colors.indigo;
    canvas.drawRect(rect,paint);
    canvas.drawRect(rect2,paint);

    goldCoin.getSprite().renderRect(canvas,Rect.fromLTWH(x+5,y1+spacing/2,16,16));
    counter+=1;
    if(counter==20){
      goldCoin.update(2);
    }else if(counter==40){
      goldCoin.update(3);
    }else if(counter==60){
      goldCoin.update(4);
    }else if(counter==80){
      goldCoin.update(5);
    }else if(counter==100){
      goldCoin.update(1);
      counter = 1;
    }


  }
}