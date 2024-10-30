import 'package:coffe_app/drink.dart';
import 'package:coffe_app/drinkCard.dart';
import 'package:flutter/material.dart';
import 'package:coffe_app/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late PageController pageController; 
  double pageOffset = 0; 
  late AnimationController controller; 
  late Animation<double> animation; 

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack,
    );

    pageController = PageController(viewportFraction: 0.8);

    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page ?? 0; 
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildToolBar(), 
            buildLogo(size), 
            buildPager(size), 
            buildPageIndicator(), 
          ],
        ),
      ),
    );
  }

  Widget buildToolBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20),
          AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.translate(
                offset:  Offset(-200 * (1 - animation.value), 0),
                child: Image.asset('images/location.png', width: 40, height: 40),
              );
            }
          ), 
          Spacer(), 
          AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(200 * (1 - animation.value), 0),
                child: Image.asset('images/drawe.png', width: 40, height: 40),
              );
            }
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width / 2 - 25,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..translate(0.0, size.height / 2 * (1 - animation.value))
              ..scale(1 + (1 - animation.value)),
            origin: Offset(25, 25),
            child: InkWell(
              onTap: () => controller.isCompleted ? controller.reverse() : controller.forward(),
              child: Image.asset('images/logo.png', width: 60, height: 60),
            ),
          );
        },
      ),
    );
  }

  Widget buildPager(Size size) {
    final drinks = getDrinks();

    return Container(
      margin: EdgeInsets.only(top: 70),
      height: size.height - 50,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, snapshot) {
          return Transform.translate(
            offset: Offset(400 * (1 - animation.value), 0),
            child: PageView.builder(
              controller: pageController,
              itemCount: drinks.length,
              itemBuilder: (context, index) {
                return DrinkCard(
                  drink: drinks[index],
                  pageOffset: pageOffset,
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }

  List<Drink> getDrinks() {
    List<Drink> list = [];
    list.add(Drink(
  'Max',
  'Verstappen',
  'images/max.jpg',
  'images/bean_top.png',
  'images/bean_small.png',
  'images/cascomp.png',
  'images/funkomax.png', // Asegúrate de usar la ruta correcta
  'Max Verstappen es un piloto holandés que compite en la Fórmula 1 para el equipo Red Bull Racing. \nConsolidándose como uno de los pilotos más talentosos y veloces en el deporte a una edad temprana.',
  mBrownLight,
  mBrown,

));

    list.add(Drink(
      'Sergio',
      ' Perez',
      'images/checo.jpg',
      'images/greentop.png',
      'images/greensmal.png',
      'images/cascomp.png',
      'images/funkocheco.png',
      'Checo es el piloto mexicano más exitoso en la Fórmula 1 y ha logrado varias vi \nEs conocido por su consistencia en pista, habilidad para cuidar los neumáticos y su experiencia en la categoría',
      mBrownLight,
      mBrown,
    ));

    list.add(Drink(
      'Pato',
      ' O Ward',
      'images/pato.jpg',
      'images/greentop.png',
      'images/greensmal.png',
      'images/cascopatp.png',
      'images/funkopato.png',
      '"Pato OWard es un piloto mexicano que compite en la serie IndyCar para el equipo Arrow McLaren.\nEs considerado uno de los pilotos jóvenes más prometedores y ha generado interés.',
      greenLight,
      greenDark,
    ));

    return list;
  }
  
  Widget buildPageIndicator() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, snapshot) {
        return Positioned(
          bottom: 10,
          left: 10,
          child: Opacity(
            opacity: controller.value,
            child: Row(
              children: List.generate(
                getDrinks().length,
                (index) => buildContainer(index),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildContainer(int index) {
    double animate = pageOffset - index;
    double size = 10;
    animate = animate.abs();
    Color color = const Color.fromARGB(255, 209, 5, 5);

    if (animate <= 1 && animate >= 0) {
      size = 10 + 10 * (1 - animate);
      color = ColorTween(begin: Colors.grey, end: mAppGreen).transform(1 - animate)!;
    }

    return Container(
      margin: const EdgeInsets.all(4),
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}