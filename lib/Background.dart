import 'package:flutter/material.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/sprite.dart';


class Background{
  Sprite background;
  Rect backgroundRect;
  Background(){
    loadBackground();

  }
  void loadBackground(){
    background = Sprite('background.png');
    backgroundRect = Rect.fromLTWH(0,0,430,732);

  }
  void render(Canvas canvas){


    this.background.renderRect(canvas,this.backgroundRect);


  }


}