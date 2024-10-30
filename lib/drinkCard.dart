import 'package:coffe_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:coffe_app/drink.dart';
import 'dart:math' as math;

class DrinkCard extends StatelessWidget {
  final Drink drink;
  final double pageOffset;
  final int index;
  final double animation;
  final double animate;
  final double columAnimation;

  const DrinkCard({
    Key? key,
    required this.drink,
    required this.pageOffset,
    required this.index,
    this.animation = 0,
    this.animate = 0,
    this.columAnimation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth = size.width - 60;
    double cardHeight = size.height * .55;
    double count = 0;
    double page = pageOffset;
    double rotation = (index - pageOffset) * (math.pi / 14);

    while (page > 1) {
      page--;
      count++;
    }

    double localAnimation = Curves.easeOutBack.transform(page);
    double localAnimate = 100 * (count + localAnimation);
    double columAnimation = 50 * (count + localAnimation);

    for (int i = 0; i < index; i++) {
      localAnimate -= 100;
      columAnimation -= 50;
    }

    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          buildTopText(),
          buildBackgroundImage(cardWidth, cardHeight, size),
          buildAboveCard(cardWidth, cardHeight, size, columAnimation),
          buildCupImage(size, rotation),
          buildBlurImage(cardWidth, size, localAnimate),
          buildSmallImage(size, localAnimate),
          buildTopImage(cardWidth, cardHeight, size, localAnimate),
        ],
      ),
    );
  }

  Widget buildTopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20),
          Text(
            drink.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: drink.lightColor),
          ),
          Text(
            drink.conName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: drink.darkColor),
          ),
        ],
      ),
    );
  }
Widget buildBackgroundImage(double cardWidth, double cardHeight, Size size) {
  return Positioned(
    width: cardWidth,
    height: cardHeight,
    bottom: size.height * .15,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset(
          drink.backgroundImage, // Esta línea es correcta
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

  Widget buildAboveCard(double cardWidth, double cardHeight, Size size, double columAnimation) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .15,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: drink.darkColor.withOpacity(.50),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.all(30),
        child: Transform.translate(
          offset: Offset(-columAnimation, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Funko Pop',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                drink.description,
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: 5),
                  Image.asset('images/monoplaza.png', width: 50, height: 50),
                  SizedBox(width: 5),
                  Image.asset('images/monoplaza.png', width: 45, height: 45),
                  SizedBox(width: 5),
                  Image.asset('images/monoplaza.png', width: 40, height: 40),
                  SizedBox(width: 5),
                ],
              ),
              SizedBox(height: 15),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: mAppGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        '\$',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '300',
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                      Text(
                        '.00',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCupImage(Size size, double rotation) {
    return Positioned(
      bottom: 20,
      right: -size.width * .2 / 2 - 100,
      child: Transform.rotate(
        angle: rotation,
        child: Image.asset(
          drink.cupImage,
          height: size.height * .55 - 15,
        ),
      ),
    );
  }

  Widget buildBlurImage(double cardWidth, Size size, double localAnimate) {
    return Positioned(
      right: cardWidth / 2 - 60 + localAnimate,
      bottom: size.height * .10,
      child: Image.asset(drink.imageBlur, width: 100, height: 100),
    );
  }

  Widget buildSmallImage(Size size, double localAnimate) {
    return Positioned(
      right: -10 + localAnimate,
      top: size.height * .3,
      child: Image.asset(drink.imageBlur, width: 90, height: 90),
    );
  }

  Widget buildTopImage(double cardWidth, double cardHeight, Size size, double localAnimate) {
    return Positioned(
      left: cardWidth / 4 - localAnimate,
      bottom: size.height * .15 + cardHeight - 25,
      child: Image.asset(drink.imageBlur, width: 100, height: 100),
    );
  }
}