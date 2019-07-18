import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'Game.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DeathScreen.dart';
import 'package:flame/flame_audio.dart';

void main() async{
  bool cancer = false;

  Util flameUtil = Util();
  await flameUtil.fullScreen();

  var prefs = await SharedPreferences.getInstance();

  DeathScreen.highScore = prefs.getInt("highScore");

  Flame.images.load("monkey.png");
  Flame.images.load("background.png");
  Flame.images.load("coin.png");
  Flame.images.load("coin.png");
  Flame.images.load("trump.png");
  Flame.images.load("nyancat.png");
  Flame.images.load("brickWall.png");
  Flame.images.load("longBack.png");
  Flame.images.load("longBack2.png");
  Flame.images.load("spaceBackground.png");
  Flame.images.load("spaceBackground2.png");

  Flame.audio.load('buildWall.mp3');
  Flame.audio.load('music.mp3');
  if(cancer){
    FlameAudio audio = new FlameAudio();
    audio.loopLongAudio('music.mp3');
  }
  bGame game = bGame();
  game.coins =prefs.getInt("coinTotal");
  String link = prefs.getString('currentLink');
  if(link!=null) {
    game.b.changeSprite( prefs.getString('currentLink'));
    int i =0;
    for(String link2 in game.sprites){
      if(link2==link){
        game.index=i;
      }
      i+=1;
    }
  }else{
    link = 'monkey.png';
    game.b.changeSprite( prefs.getString(link));
  }
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;

  runApp(game.widget);

  flameUtil.addGestureRecognizer(tapper);

}
