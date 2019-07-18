import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flame/sprite.dart';
import 'package:flame/animation.dart' as animation;
import 'package:random_color/random_color.dart';

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
  void render(Canvas canvas,Paint paint,bool isTrump, bool cancer){
    if(cancer) {
      RandomColor _randomColor = RandomColor();

      paint.color = _randomColor.randomColor();


      Rect rect = Rect.fromLTWH(x, 0, width, y1);
      Rect rect2 = Rect.fromLTWH(x, y2, width, 750 - y2);
      canvas.drawRect(rect, paint);
      canvas.drawRect(rect2, paint);
      if (showCoin) {
        goldCoin.getSprite().renderRect(
            canvas, Rect.fromLTWH(x + 10, y1 + spacing / 2, 16, 16));
        goldCoin.update(0.01);



    }
    }else{
      if (isTrump) {
        Rect rect = Rect.fromLTWH(x, 0, width, y1);
        Rect rect2 = Rect.fromLTWH(x, y2, width, 750 - y2);

        paint.color = Colors.red;
        canvas.drawRect(rect, paint);
        canvas.drawRect(rect2, paint);

        rect = Rect.fromLTWH(x + width / 4, 0, 3 * width / 4, y1);
        rect2 = Rect.fromLTWH(x + width / 4, y2, 3 * width / 4, 750 - y2);

        paint.color = Colors.white;
        canvas.drawRect(rect, paint);
        canvas.drawRect(rect2, paint);

        rect = Rect.fromLTWH(x + 2 * width / 4, 0, width / 2, y1);
        rect2 = Rect.fromLTWH(x + 2 * width / 4, y2, 2 * width / 4, 750 - y2);

        paint.color = Colors.red;
        canvas.drawRect(rect, paint);
        canvas.drawRect(rect2, paint);

        rect = Rect.fromLTWH(x + 3 * width / 4, 0, width / 4, y1);
        rect2 = Rect.fromLTWH(x + 3 * width / 4, y2, width / 4, 750 - y2);

        paint.color = Colors.white;
        canvas.drawRect(rect, paint);
        canvas.drawRect(rect2, paint);

        rect = Rect.fromLTWH(x, 0, width, y1);
        paint.color = Colors.indigoAccent;
        canvas.drawRect(rect, paint);
        if (showCoin) {
          goldCoin.getSprite().renderRect(
              canvas, Rect.fromLTWH(x + 10, y1 + spacing / 2, 16, 16));
          goldCoin.update(0.01);
        }
      } else {
        Rect rect = Rect.fromLTWH(x, 0, width, y1);
        Rect rect2 = Rect.fromLTWH(x, y2, width, 750 - y2);

        paint.color = Colors.indigo;
        canvas.drawRect(rect, paint);
        canvas.drawRect(rect2, paint);
        if (showCoin) {
          goldCoin.getSprite().renderRect(
              canvas, Rect.fromLTWH(x + 10, y1 + spacing / 2, 16, 16));
          goldCoin.update(0.01);
        }
      }
    }
    }
  }
