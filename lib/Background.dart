import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'package:random_color/random_color.dart';
import 'package:flame/components/component.dart';
import 'package:flame/flame_audio.dart';

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
    this.backgroundComponent.x = 0.0;
    this.backgroundComponent2.x = 1280.0;
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
      if(this.backgroundComponent.x < -1280.0){
        this.backgroundComponent.x = 0.0;
      }
      this.backgroundComponent.x -= 0.2;

      this.backgroundComponent.render(canvas);
      this.backgroundComponent2.render(canvas);

      canvas.restore();

    }
  }
  void changeBackground(String link){
    background = Sprite(link);
  }
  void changeBackground2(int index){
    if(index == 0){
      background = Sprite('longBack.png');
      var background2 = Sprite('longBack2.png');

      this.backgroundComponent = SpriteComponent.fromSprite(1280.0, 732.0, this.background);
      this.backgroundComponent2 = SpriteComponent.fromSprite(1280.0, 732.0, background2);

      this.backgroundComponent.x = 0.0;
      this.backgroundComponent2.x = 1280.0;

      FlameAudio audio = new FlameAudio();
      audio.loopLongAudio('');

    }else if(index == 2){
      background = Sprite('spaceBackground.png');
      var background2 = Sprite('spaceBackground.png');

      this.backgroundComponent = SpriteComponent.fromSprite(1280.0, 732.0, this.background);
      this.backgroundComponent2 = SpriteComponent.fromSprite(1280.0, 732.0, background2);

      this.backgroundComponent.x = 0.0;
      this.backgroundComponent2.x = 1280.0;

      FlameAudio audio = new FlameAudio();
      audio.loopLongAudio('nyancat.mp3');
    }

  }


}