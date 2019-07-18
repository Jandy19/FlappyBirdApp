import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'package:random_color/random_color.dart';
import 'package:flame/components/component.dart';

class Background{
  Sprite background;
  Rect backgroundRect;
  Rect backgroundRect2;

  var backgroundComponent;
  var backgroundComponent2;


  Background(){
    loadBackground();

  }
  void loadBackground(){
    background = Sprite('longBack.png');
    var background2 = Sprite('longBack2.png');
    this.backgroundComponent = SpriteComponent.fromSprite(1280.0, 732.0, this.background);
    this.backgroundComponent2 = SpriteComponent.fromSprite(1280.0, 732.0, background2);
    this.backgroundComponent.x=0.0;
    this.backgroundComponent2.x=1280.0;
    backgroundRect = Rect.fromLTWH(0,0,430,732);

  }
  void render(Canvas canvas,Paint paint,bool isTrump,bool cancer){
    if(cancer) {
      RandomColor _randomColor = RandomColor();

      paint.color = _randomColor.randomColor();

      canvas.drawRect(backgroundRect, paint);


    }else if(isTrump){
      background.renderRect(canvas,backgroundRect);
    }else{

      if(this.backgroundComponent.x< -1280.0){
        this.backgroundComponent.x= 1280.0;
      }if(this.backgroundComponent2.x< -1280){
        this.backgroundComponent2.x=1280.0;

      }
      print(this.backgroundComponent.x);
      print(this.backgroundComponent2.x);
      this.backgroundComponent.x -= 0.5;
      this.backgroundComponent2.x -= 0.5;
      bool restored = false;
      if(this.backgroundComponent.x<430&&this.backgroundComponent.x>-1280){
      this.backgroundComponent.render(canvas);
          canvas.restore();

      }if(this.backgroundComponent2.x<430&&this.backgroundComponent2.x>-1280){
        this.backgroundComponent2.render(canvas);
          canvas.restore();


    }
    }

  }
  void changeBackground(String link){
    background = Sprite(link);

  }
  void changeBackground2(int index){
    if(index==0){
      background = Sprite('longBack.png');
      var background2 = Sprite('longBack2.png');
      this.backgroundComponent = SpriteComponent.fromSprite(1280.0, 732.0, this.background);
      this.backgroundComponent2 = SpriteComponent.fromSprite(1280.0, 732.0, background2);
    }else if(index==2){
      background = Sprite('spaceBackground.png');
      var background2 = Sprite('spaceBackground.png');
      this.backgroundComponent = SpriteComponent.fromSprite(1280.0, 732.0, this.background);
      this.backgroundComponent2 = SpriteComponent.fromSprite(1280.0, 732.0, background2);

    }

  }


}