import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';

class Background{
  Sprite backgroundSprite;
  Rect backgroundRect;
  Background(){
    this.backgroundSprite = Sprite('background.png');
    this.backgroundRect = Rect.fromLTWH(0,0,461,732);

  }
  void render(Canvas canvas){
    this.backgroundSprite.renderRect(canvas,this.backgroundRect);

  }


}