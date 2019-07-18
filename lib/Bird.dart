
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';

class Bird{
  double x,y,speed;
  Sprite bird;
  var birdComponent;
  double angleSpeed = 0.04;
  Bird(String link,{this.x=50,this.y=730/2}){
    this.speed = 1;
    this.bird = Sprite(link);
    this.birdComponent = SpriteComponent.fromSprite(50, 50, this.bird);
  }
  void moveUp(){

    this.speed=-5;

  }

  void fall(){
    this.y+= this.speed;

    if(this.speed<8){
      this.speed+=0.5;
      this.birdComponent.x=this.x+50;
      this.birdComponent.y=this.y+50;

      this.birdComponent.angle += this.speed / 10;

      this.birdComponent.x=this.x-50;
      this.birdComponent.y=this.y-50;
    }
  }
  double getX(){

    return this.x;
  }
  double getY(){

    return this.y;
  }
  void render(Canvas canvas,double height){

    this.birdComponent.x=this.x;
    this.birdComponent.y=this.y;
    birdComponent.render(canvas);

    //Rect birdRect = new Rect.fromLTWH(this.x, this.y,height,height*0.84);
    //this.bird.renderRect(canvas,birdRect);

  }
  void renderXY(Canvas canvas,double height,double x, double y){

    Rect birdRect = new Rect.fromLTWH(x, y, height, height*0.84);
    this.bird.renderRect(canvas,birdRect);

  }
  void changeSprite(String link){
    this.bird = Sprite(link);
    this.birdComponent = SpriteComponent.fromSprite(50, 50, this.bird);
  }

}