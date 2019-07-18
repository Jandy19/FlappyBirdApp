import 'package:flutter/material.dart';
import 'Bird.dart';

class ShopScreen{


  RRect shopScreenRRect;
  int coins;
  static int cost =0;
  static bool current = true;
  static String link='monkey.png';
  ShopScreen(this.coins){
    this.shopScreenRRect = RRect.fromRectAndRadius(Rect.fromLTWH(75,200,275,300),Radius.circular(10));

  }
  void render(Canvas canvas,Paint paint,Bird bird){

    paint.color = Colors.deepPurple;
    canvas.drawRRect(this.shopScreenRRect,paint);

    paint.color = Colors.deepPurpleAccent;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(95,220,40,30),Radius.circular(2)),paint);

    bird.renderXY(canvas,100,160,300);

    Path pathRight = Path();

    pathRight.moveTo(110,350);
    pathRight.lineTo(120,330);
    pathRight.lineTo(120,370);
    pathRight.close();

    canvas.drawPath(pathRight,paint);

    Path pathLeft = Path();

    pathLeft.moveTo(310,350);
    pathLeft.lineTo(300,330);
    pathLeft.lineTo(300,370);
    pathLeft.close();

    canvas.drawPath(pathLeft,paint);


    paint.color = Colors.deepPurpleAccent;
    canvas.drawRect(Rect.fromLTWH(163,400,100,30),paint);

    TextSpan coinSpan = new TextSpan(style: new TextStyle(color: Colors.white,fontSize:10,fontWeight:FontWeight.bold), text: 'Coins: $coins');
    TextSpan backSpan = new TextSpan(style: new TextStyle(color: Colors.white,fontSize:10,fontWeight:FontWeight.bold), text: 'Back');
    TextSpan buySpan;
    Offset offset;
    cost = ShopScreen.cost;
    current = ShopScreen.current;
    if(cost==0 && current) {
      buySpan = new TextSpan(style: new TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          text: 'Current');
      offset = new Offset(180, 403);
    }else if(cost==0 && !current) {
      buySpan = new TextSpan(style: new TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          text: 'Choose');
      offset = new Offset(180, 403);
    }else{
       buySpan = new TextSpan(style: new TextStyle(
          color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold),
          text: '$cost');
       offset = new Offset(195, 403);

    }
    TextPainter tp = new TextPainter(text: coinSpan, textAlign: TextAlign.left);
    TextPainter tp2 = new TextPainter(text: backSpan, textAlign: TextAlign.left);
    TextPainter tp3 = new TextPainter(text: buySpan, textAlign: TextAlign.left);


    tp.textDirection=TextDirection.ltr;
    tp.layout();
    tp.paint(canvas, new Offset(250, 230));

    tp2.textDirection=TextDirection.ltr;
    tp2.layout();
    tp2.paint(canvas, new Offset(105, 230));

    tp3.textDirection=TextDirection.ltr;
    tp3.layout();
    tp3.paint(canvas, offset);

  }

}