import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'Game.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DeathScreen.dart';


void main() async{

  Util flameUtil = Util();
  await flameUtil.fullScreen();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  DeathScreen.highScore = prefs.getInt("highScore");

  Flame.images.load("monkey.png");
  Flame.images.load("background.png");

  bGame game = bGame();

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;

  runApp(game.widget);

  flameUtil.addGestureRecognizer(tapper);

}
