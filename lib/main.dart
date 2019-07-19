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

  // Getting High Score from Shared Preferences
  var prefs = await SharedPreferences.getInstance();
  DeathScreen.highScore = prefs.getInt("highScore");

  // Loading the Game Assets
  Flame.images.loadAll(["monkey.png","trump.png","nyancat.png","brickWall.png","longBack.png","longBack2.png","spaceBackground.png","spaceBackground2.png"]);
  Flame.audio.loadAll(['buildWall.mp3','music.mp3','nyancat.mp3']);

  // Starting the game
  bGame game = bGame();

  // Setting the games total coins
  game.coins =prefs.getInt("coinTotal");

  // Setting the sprite image
  String link = prefs.getString('currentLink');
  if(link!=null) {
    game.player.changeSprite( prefs.getString('currentLink'));
    int i =0;
    for(String link2 in game.sprites){
      if(link2==link){
        game.index=i;
      }
      i+=1;
    }
  }else{
    link = 'monkey.png';
    game.player.changeSprite( prefs.getString(link));
  }
  // Initializing the GestureRecognizer
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;

  // Running the game
  runApp(game.widget);

  flameUtil.addGestureRecognizer(tapper);

}
