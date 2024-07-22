import 'package:day_6_app/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day 06 App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;

  late AnimationController rippleController;
  late AnimationController scaleController;

  late Animation<double> rippleAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    rippleController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: const Dashboard()));
        }
      });

    rippleAnimation = Tween<double>(
      begin: 80.00,
      end: 90.00,
    ).animate(rippleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          rippleController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          rippleController.forward();
        }
      });

    scaleAnimation = Tween<double>(
      begin: 1.00,
      end: 30.00,
    ).animate(scaleController);

    rippleController.forward();
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          makePage(
            image: 'assets/images/one.jpg',
          ),
          makePage(
            image: 'assets/images/two.jpg',
          ),
          makePage(
            image: 'assets/images/three.jpg',
          ),
        ],
      ),
    );
  }

  Widget makePage({required String image}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(.3),
              Colors.black.withOpacity(.3),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(45.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
              ),
              Text(
                'Exercise 1',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '15',
                    style: TextStyle(
                      color: Colors.yellow[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    'Minutes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3',
                    style: TextStyle(
                      color: Colors.yellow[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    'Exercises',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Text(
                'Start the morning with your health',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 42,
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedBuilder(
                  animation: rippleAnimation,
                  builder: (context, child) => Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 18,
                    ),
                    width: rippleAnimation.value,
                    height: rippleAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(.4),
                    ),
                    child: InkWell(
                      onTap: () {
                        scaleController.forward();
                      },
                      child: AnimatedBuilder(
                        animation: scaleAnimation,
                        builder: (context, child) => Transform.scale(
                          scale: scaleAnimation.value,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
