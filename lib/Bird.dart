import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
class Bird{
  double x,y,speed;
  Sprite bird;
  Bird(var height){
    this.x=50;
    this.y=height/2;
    this.speed = 1;
    this.bird = Sprite("monkey.png");
  }
  void moveUp(){
    this.speed=-5;
  }
  void fall(){
    this.y+= this.speed;
    if(this.speed<5){
      this.speed+=0.5;
    }
  }
  double getX(){

    return this.x;
  }
  double getY(){

    return this.y;
  }
  void render(Canvas canvas){
    Rect birdRect = new Rect.fromLTWH(this.x, this.y, 50, 50);
    this.bird.renderRect(canvas,birdRect);
  }

}