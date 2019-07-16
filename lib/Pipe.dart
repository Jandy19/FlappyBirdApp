import 'package:flutter/material.dart';
import 'dart:math';
class Pipe{
  double x,y1,y2;
  var speed = 1;
  double width = 40;
  Pipe(){
    var rng = new Random();
    this.x=461;
    this.y1=rng.nextDouble()*600;
    print(y1);
    this.y2=this.y1+100;
  }
  void move(){
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
}