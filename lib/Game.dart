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
  Bird player = Bird('monkey.png');
  Background background = Background();
  Paint paint = Paint();

  var sprites = ['monkey.png','trump.png','nyancat.png'];
  var costs = [0,100,150];

  int index = 0;
  var pipes = [];
  var score=0;
  var coins;

  bool cancer = false;
  bool first = true;
  bool lost = false;
  bool start = false;
  bool inShop = false;

  void render(Canvas canvas){
    if(!lost){
      var rng = Random();

      // Creating a new pipe randomly but after the previous one has passed a certain point
      if(rng.nextInt(100) < 5) {
        int flag = 1;
        for(Pipe x in pipes){
          if(x.getX() > 200){
            flag = 0;
          }
        }

        if(flag == 1) {
          pipes.add(Pipe());
        }
      }

      Paint paint = Paint();
      paint.color = Colors.blue;

      background.render(canvas,paint,player.isTrump,cancer);

      // Changing the background depending on the image of the sprite
      if(first) {
        if (player.isTrump) {
          background.changeBackground('brickWall.png');
        } else{
          background.changeBackground2(index);
        }
        first = false;
      }

      // Displaying the pipe
      for (Pipe x in pipes){
        x.render(canvas,paint,index,cancer);
      }

      // Displaying the score to the screen
      TextSpan span = new TextSpan(style: new TextStyle(color: Colors.white,fontSize:30), text: '$score');
      TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left);
      tp.textDirection=TextDirection.ltr;
      tp.layout();
      tp.paint(canvas, new Offset(200, 30));

      // Displaying the player to the screen
      player.render(canvas,50);


      score = 0;
      for(Pipe x in pipes){
        // Deciding if the player has hit a pipe
        if((x.getX() > 10 && x.getX() < 93)){
          if(player.getY() < x.getY1() || player.getY() + 43 > x.getY2()) {
            lost = true;
          }else if(x.getX() < 75 && x.showCoin){
            // Changing the coin so it is no longer displayed once it has been collected
            x.coinCollected();
            coins += 1;
          }
        }
        // Calculating the current score depending on how many pipes have passed
        if(x.getX() < 50){
          score += 1;
        }
      }

    }
    if(lost) {
      if(!inShop) {
        // Deciding if the score is greater then the previous high score and changing it if so
        if (score > DeathScreen.highScore) {
          setHighScore(score);
        }

        updateCoinCount();

        background.render(canvas,paint,player.isTrump,cancer);

        // Displaying the death screen
        DeathScreen deathScreen = DeathScreen(score);
        deathScreen.render(canvas, paint, coins);

      }else if(inShop){
        // Updating the shopscreens sprite image
        changePrefsLink(sprites[index]);
        ShopScreen.link = sprites[index];

        background.render(canvas,paint,player.isTrump,cancer);

        // Displaying the shopscreen to the user
        ShopScreen shopScreen = ShopScreen(coins);
        shopScreen.render(canvas,paint,player);
      }
    }
  }
  void updateCoinCount() async{

    // Updating the coin total stored on the phone
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("coinTotal",coins);

  }
  void setHighScore(int score) async{
    // Updating the high score on the phone
    DeathScreen.highScore = score;

    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("highScore",score);


  }
  void update(double t){

    if(start){
      // Deciding if the player has hit the bottom of the screen or if the players sprite needs to fall
      if(player.getY() < 732) {
        player.fall();
      }else{
        lost = true;
      }
      // Moving all of the pipes
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
    // Starts the game when the player first clicks
    if(start == false){
      start = true;
    }else{
      // Moves the player up when the player clicks
      if(player.getY() > 25){
        player.moveUp();
      }
      if(!inShop) {
        // Restarting the game when the player clicks the restart button on the deathscreen
        if (lost &&
            (d.globalPosition.dx > 125 && d.globalPosition.dx < 300 &&
                d.globalPosition.dy > 400 && d.globalPosition.dy < 440)) {
          lost = false;
          start = false;
          player.y = 730/2;
          pipes = [];
        } else if (lost &&
            (d.globalPosition.dx > 125 && d.globalPosition.dx < 200 &&
                d.globalPosition.dy > 350 && d.globalPosition.dy < 390)) {
          // Changes the screen to the shop screen when the player clicks the shop button on the deathscreen
          inShop = true;
        }
      }else{
        // Changes the sprite displayed when the left arrow is pressed on the shopscreen
        if(d.globalPosition.dx > 110 && d.globalPosition.dx < 130 &&
            d.globalPosition.dy > 330 && d.globalPosition.dy < 370){
          index -= 1;
          if(index < 0 ){
            index = sprites.length-1;
          }
          player.changeSprite(sprites[index]);
          // Updating the price on the shopscreen and checking to see if the owner owns the sprite image
          if(sprites[index] != ShopScreen.link) {
            getCost(index);
            ShopScreen.current = false;
          }else{
            getCost(index);
            ShopScreen.current = true;
          }
        // Changes the sprite displayed when the right arrow is pressed on the shopscreen
        }else if(d.globalPosition.dx > 300 && d.globalPosition.dx < 340 &&
            d.globalPosition.dy > 330 && d.globalPosition.dy < 370){
          index += 1;
          if(index > sprites.length-1){
            index = 0;
          }
          player.changeSprite(sprites[index]);
          // Updating the price on the shopscreen and checking to see if the owner owns the sprite image
          if(sprites[index] != ShopScreen.link) {
            getCost(index);
            ShopScreen.current = false;
          }else{
            getCost(index);
            ShopScreen.current = true;
          }
          // Restarts the game when the player clicks the back button on the shopscreen
        }if(d.globalPosition.dx > 95 && d.globalPosition.dx < 135 &&
            d.globalPosition.dy > 220 && d.globalPosition.dy < 250){

          player.changeSprite(ShopScreen.link);

          if(ShopScreen.link == 'trump.png'){
            background.changeBackground('brickWall.png');
          }else if(ShopScreen.link == 'nyancat.png'){
            background.changeBackground2(2);
          }else if(ShopScreen.link == 'monkey.png'){
            background.changeBackground2(0);
          }
          lost = false;
          start = false;
          player.y = 730/2;
          pipes = [];
          inShop = false;
        }
        // Buys the current sprite image or changes the sprite to the image when the buy button is pressed on the shopscreen
        if(d.globalPosition.dx > 163 && d.globalPosition.dx < 263 &&
            d.globalPosition.dy > 400 && d.globalPosition.dy < 430 && !ShopScreen.current){
          if(ShopScreen.cost == 0){
            ShopScreen.link = sprites[index];
            changePrefsLink(sprites[index]);
            ShopScreen.current = true;
          }else if(ShopScreen.cost < coins){
              coins -= ShopScreen.cost;
              updateCoinCount();

              ShopScreen.link = sprites[index];
              updatePrefs(index);
              changePrefsLink(sprites[index]);

              ShopScreen.cost = 0;
              ShopScreen.current = true;
          }
        }
      }
    }
  }
  void updatePrefs(int index) async{
    // Updates the phone storage when the play buys a sprite

    this.index = index;
    var prefs = await SharedPreferences.getInstance();

    if(index == 1){
      prefs.setBool('ownTrump',true);
    }else if(index == 2){
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
    if(player.isTrump){
      background.changeBackground('brickWall.png');
    }else if(index == 0){
      background.changeBackground2(index);
    }else if(index == 2){
      background.changeBackground2(index);
    }
    if(index == 1){
      if(prefs.getBool('ownTrump') == null) {
        ShopScreen.cost = costs[1];
      }else if(prefs.getBool('ownTrump')){
        ShopScreen.cost = 0;
      }
    }else if(index == 0){
      ShopScreen.cost = 0;
    }else if(index==2){
      if(prefs.getBool('ownNyanCat') == null) {
        ShopScreen.cost = costs[2];

      }else if(prefs.getBool('ownNyanCat')){
        ShopScreen.cost = 0;

    }
    }


  }
}