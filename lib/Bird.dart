
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';

class Bird{
  double x,y,speed;
  Sprite bird;

  Bird(String link,{this.x=50,this.y=730/2}){
    this.speed = 1;
    this.bird = Sprite(link);

  }
  void moveUp(){
    this.speed=-5;
  }
  void fall(){
    this.y+= this.speed;

    if(this.speed<8){
      this.speed+=0.5;

    }
  }
  double getX(){

    return this.x;
  }
  double getY(){

    return this.y;
  }
  void render(Canvas canvas,double height){

    Rect birdRect = new Rect.fromLTWH(this.x, this.y,height,height*0.84);
    this.bird.renderRect(canvas,birdRect);
  }
  void renderXY(Canvas canvas,double height,double x, double y){

    Rect birdRect = new Rect.fromLTWH(x, y, height, height*0.84);
    this.bird.renderRect(canvas,birdRect);

  }
  void changeSprite(String link){
    this.bird = Sprite(link);
  }

}