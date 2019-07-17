import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class CoinSprite{
  Sprite coinSprite;
  CoinSprite(){
    coinSprite = Sprite("coin.png");
  }
  void render(Canvas canvas){
    coinSprite.renderRect(canvas,Rect.fromLTWH(6,6,15,15));

  }

}