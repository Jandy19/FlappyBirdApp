import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';
import 'dart:math';

class Bird{
  // Initializing attributes
  double x,y,speed;
  Sprite bird;
  var birdComponent;
  bool isTrump = false;

  Bird(String link,{this.x = 75,this.y = 730 / 2}){
    this.speed = 1;
    // Deciding whether or not trump is the sprite
    if(link == 'trump.png'){
      isTrump = true;
    }else{
      isTrump = false;
    }
    // Creating the bird sprite
    this.bird = Sprite(link);
    this.birdComponent = SpriteComponent.fromSprite(50, 50, this.bird);
  }
  void moveUp(){
    // Changing the speed so the bird falls up and resetting the angle of the image to normal
    this.speed =- 6;
    this.birdComponent.angle = 0.0;

  }

  void fall(){
    this.y += this.speed;

    // Accelerating the speed the bird falls at
    if(this.speed < 8){
      this.speed += 0.5;

      // Changing the angle of the bird depending on how much the bird has fallen
      if(this.speed == 2){
        this.birdComponent.angle = pi/12;
      }else if(this.speed == 3){
        this.birdComponent.angle = 2 * pi / 12;
      }else if(this.speed == 4){
        this.birdComponent.angle = 3 * pi / 12;
      }else if(this.speed == 5){
        this.birdComponent.angle = 5 * pi / 12;
      }else if(this.speed == 7 ){
        this.birdComponent.angle = pi / 2;
      }
      this.birdComponent.x += 50 * sin(this.birdComponent.angle);
    }

  }
  double getX(){
    return this.x;
  }
  double getY(){
    return this.y;
  }
  void render(Canvas canvas, double height) {
    // Updating the birds position
    this.birdComponent.y = this.y;

    // Rendering the bird to the screen
    birdComponent.render(canvas);


  }
  void renderXY(Canvas canvas,double height,double x, double y){

    // Renders the bird at a specigic point with a specific size to the screen
    Rect birdRect = new Rect.fromLTWH(x, y, height, height * 0.84);
    this.bird.renderRect(canvas,birdRect);

  }
  void changeSprite(String link){

    if(link == 'trump.png'){
      isTrump = true;
    }else{
      isTrump = false;
    }
    // Updating the bird with the new link
    this.bird = Sprite(link);
    this.birdComponent = SpriteComponent.fromSprite(50, 50, this.bird);
  }

}