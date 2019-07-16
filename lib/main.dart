import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'Game.dart';
import 'dart:async';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/util.dart';

void main() async{

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  Flame.images.load("monkey.png");
  bGame game = bGame();
  runApp(game.widget);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  runApp(game.widget);
  flameUtil.addGestureRecognizer(tapper);
}
