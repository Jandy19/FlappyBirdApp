import 'package:flame/game.dart';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flappy_bird/Bird.dart';
import 'package:flutter/gestures.dart';
import 'package:flappy_bird/Pipe.dart';
import 'Background.dart';
import 'DeathScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flappy_bird/ShopScreen.dart';

class bGame extends Game {

  Size screenSize;
  Bird b = Bird('monkey.png');
  Background background = Background();
  Paint paint = Paint();

  var sprites = ['monkey.png','trump.png','nyancat.png'];
  var costs = [0,100,150];

  int index = 0;
  var pipes = [];
  var lost = false;
  var start = false;
  var inShop = false;
  var score=0;
  var coins;

  bool cancer = false;

  void render(Canvas canvas){
    if(lost==false){

    var rng = Random();

    if(rng.nextInt(100)<5) {
      int flag = 1;
      for(Pipe x in pipes){

        if(x.getX()>200){
          flag =0;
        }

      }

      if(flag==1) {
        pipes.add(Pipe());
      }

    }
    Paint paint = Paint();
    paint.color = Colors.blue;

    background.render(canvas,paint,b.isTrump,cancer);

    if(b.isTrump){
      background.changeBackground('brickWall.png');
    }else{
      background.changeBackground('longBack.png');
    }


    for (Pipe x in pipes){
      x.render(canvas,paint,b.isTrump,cancer);
    }
    TextSpan span = new TextSpan(style: new TextStyle(color: Colors.white,fontSize:30), text: '$score');
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left);
    tp.textDirection=TextDirection.ltr;
    tp.layout();
    tp.paint(canvas, new Offset(200, 30));

    b.render(canvas,50);

    score =0;
    for(Pipe x in pipes){
      if((x.getX()>10 && x.getX()<93)){
        if(b.getY()<x.getY1() || b.getY()+43>x.getY2()) {
          lost = true;

        }else if(x.getX()<75&&x.showCoin){
          x.coinCollected();
          coins+=1;
        }
      }
      if(x.getX()<50){
        score+=1;
      }
    }

    }
    if(lost==true) {
      if(!inShop) {
        if (score > DeathScreen.highScore) {
          setHighScore(score);
        }

        updateCoinCount();

        background.render(canvas,paint,b.isTrump,cancer);

        DeathScreen deathScreen = DeathScreen(score);
        deathScreen.render(canvas, paint, coins);
      }
    if(inShop){
      changePrefsLink(sprites[index]);
      ShopScreen.link = sprites[index];
      background.render(canvas,paint,b.isTrump,cancer);

      ShopScreen shopScreen = ShopScreen(coins);
      shopScreen.render(canvas,paint,b);
    }
  }
  }
  void updateCoinCount() async{

    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("coinTotal",coins);


  }
  void setHighScore(int score) async{

    DeathScreen.highScore = score;

    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("highScore",score);


  }
  void update(double t){

    if(start==true){

    if(b.getY()<732) {
      b.fall();
    }else{
      lost = true;
    }
    for(Pipe x in pipes){
      x.move();
    }
    }

  }
  void resize(Size size){
    screenSize = size;
    super.resize(size);

  }
  void onTapDown(TapDownDetails d) async{
    if(start==false){
      start=true;
    }else{
    if(b.getY()>15){
    b.moveUp();
    }
    if(!inShop) {
      if (lost == true &&
          (d.globalPosition.dx > 125 && d.globalPosition.dx < 300 &&
              d.globalPosition.dy > 400 && d.globalPosition.dy < 440)) {
        lost = false;
        start = false;
        b.y = 730/2;
        pipes = [];
      } else if (lost == true &&
          (d.globalPosition.dx > 125 && d.globalPosition.dx < 200 &&
              d.globalPosition.dy > 350 && d.globalPosition.dy < 390)) {
        inShop = true;
      }
    }else{
      if(d.globalPosition.dx > 110 && d.globalPosition.dx < 130 &&
          d.globalPosition.dy > 330 && d.globalPosition.dy < 370){

        index-=1;
        if(index<0){
          index = sprites.length-1;
        }
        b.changeSprite(sprites[index]);
        if(sprites[index]!=ShopScreen.link) {
          getCost(index);
          ShopScreen.current = false;
        }else{
          getCost(index);
          ShopScreen.current = true;
        }
      }else if(d.globalPosition.dx > 300 && d.globalPosition.dx < 340 &&
          d.globalPosition.dy > 330 && d.globalPosition.dy < 370){

        index+=1;
        if(index>sprites.length-1){
          index = 0;
        }
        b.changeSprite(sprites[index]);
        if(sprites[index]!=ShopScreen.link) {
          getCost(index);
          ShopScreen.current = false;
        }else{
          getCost(index);
          ShopScreen.current = true;

        }


      }if(d.globalPosition.dx > 95 && d.globalPosition.dx < 135 &&
          d.globalPosition.dy > 220 && d.globalPosition.dy < 250){
        b.changeSprite(ShopScreen.link);
        if(ShopScreen.link=='trump.png'){
          background.changeBackground('brickWall.png');
        }else{
          background.changeBackground('background.png');
        }
        lost = false;
        start = false;
        b.y = 730/2;
        pipes = [];
        inShop = false;
      }
      if(d.globalPosition.dx > 163 && d.globalPosition.dx < 263 &&
          d.globalPosition.dy > 400 && d.globalPosition.dy < 430 && !ShopScreen.current){
        if(ShopScreen.cost==0){
        ShopScreen.link = sprites[index];
        changePrefsLink(sprites[index]);
        ShopScreen.current =true;
      }else if(ShopScreen.cost<coins){
          coins-=ShopScreen.cost;
          updateCoinCount();
          ShopScreen.link = sprites[index];
          updatePrefs(index);
          changePrefsLink(sprites[index]);
          ShopScreen.cost =0;
          ShopScreen.current = true;
      }

    }

    }
  }



  }
  void updatePrefs(int index) async{
    var prefs = await SharedPreferences.getInstance();
    if(index==1){
      prefs.setBool('ownTrump',true);
    }if(index==2){
      prefs.setBool('ownNyanCat',true);
    }


  }
  void changePrefsLink(String link) async{
    var prefs = await SharedPreferences.getInstance();
    DeathScreen.highScore = prefs.getInt("highScore");
    prefs.setString('currentLink',link);

  }
  getCost(int index) async{
    var prefs = await SharedPreferences.getInstance();
    if(index==1){
      if(prefs.getBool('ownTrump')==null) {
        ShopScreen.cost=costs[1];
      }else if(prefs.getBool('ownTrump')){
        ShopScreen.cost=0;
      }
    }else if(index==0){
      ShopScreen.cost =0;
    }else if(index==2){
      if(prefs.getBool('ownNyanCat')==null) {
        ShopScreen.cost=costs[2];

      }else if(prefs.getBool('ownNyanCat')){
        ShopScreen.cost=0;

    }
    }


  }
}