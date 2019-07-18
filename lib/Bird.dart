
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';
import 'dart:math';
class Bird{
  double x,y,speed;
  Sprite bird;
  var birdComponent;
  double angleSpeed = 0.04;
  bool isTrump = false;

  Bird(String link,{this.x=50,this.y=730/2}){
    this.speed = 1;
    if(link=='trump.png'){
      isTrump = true;
    }else{
      isTrump = false;
    }
    this.bird = Sprite(link);
    this.birdComponent = SpriteComponent.fromSprite(50, 50, this.bird);
  }
  void moveUp(){

    this.speed=-6;
    this.birdComponent.angle =0.0;
  }

  void fall(){
    this.y+= this.speed;

    if(this.speed<8){
      this.speed+=0.5;
      if(this.speed ==3){
        this.birdComponent.angle =2*pi/12;
        this.birdComponent.x += 25*cos(this.birdComponent.angle);
      }
      if(this.speed==2){
        this.birdComponent.angle =pi/12;
        this.birdComponent.x += 25*cos(this.birdComponent.angle);
      }
      if(this.speed==4){
        this.birdComponent.angle =3*pi/12;
        this.birdComponent.x += 25*cos(this.birdComponent.angle);
      }
      if(this.speed==5){
        this.birdComponent.angle =5*pi/12;
        this.birdComponent.x += 25*cos(this.birdComponent.angle);
      }
      if(this.speed==7){
        this.birdComponent.angle =pi/2;
        this.birdComponent.x += 25*cos(this.birdComponent.angle);
      }
    }
    this.birdComponent.y -= 50*sin(this.birdComponent.angle);

  }
  double getX(){

    return this.x;
  }
  double getY(){

    return this.y;
  }
  void render(Canvas canvas,double height) {
    this.birdComponent.x = this.x;
    this.birdComponent.y = this.y;



    birdComponent.render(canvas);

    //Rect birdRect = new Rect.fromLTWH(this.x, this.y,height,height*0.84);
    //this.bird.renderRect(canvas,birdRect);

  }
  void renderXY(Canvas canvas,double height,double x, double y){

    Rect birdRect = new Rect.fromLTWH(x, y, height, height*0.84);
    this.bird.renderRect(canvas,birdRect);

  }
  void changeSprite(String link){
    if(link=='trump.png'){
      isTrump = true;
    }else{
      isTrump = false;
    }
    this.bird = Sprite(link);
    this.birdComponent = SpriteComponent.fromSprite(50, 50, this.bird);
  }

}