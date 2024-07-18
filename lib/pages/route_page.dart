import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_health_data/pages/add_plant.dart';
import 'package:plant_health_data/pages/home_page.dart';
import 'package:plant_health_data/pages/my_plant.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  int activeIndex = 0;

  Widget getPage() {
    if (activeIndex == 1) {
      return const MyPlantPage();
    }
    return const HomePage();
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: getPage(),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          backgroundColor: Colors.green[50],
          inactiveColor: Colors.grey,
          activeColor: Colors.green,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 20,
          rightCornerRadius: 20,
          icons: const [Icons.home, Icons.book_outlined],
          splashRadius: 35,
          activeIndex: activeIndex,
          onTap: (value) {
            setState(() {
              activeIndex = value;
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddPlantPage(),
          ));
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
