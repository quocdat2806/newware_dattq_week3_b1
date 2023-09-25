import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:week3b2/pages/home.dart';

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text(
      'tab2',
      style: optionStyle,
    ),
    Text(
      'tab3',
      style: optionStyle,
    ),
    Text(
      'tab4',
      style: optionStyle,
    ),
    Text(
      'tab5',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF456189),

            label: '',
            activeIcon: _dotActive("assets/images/Home.svg"),
            icon: SvgPicture.asset(
              "assets/images/Home.svg",
              height: 29,
              width: 29,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF456189),

            label: '',
            activeIcon: _dotActive("assets/images/Favorite.svg"),
            icon: SvgPicture.asset(
              "assets/images/Favorite.svg",
              height: 29,
              width: 29,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: _dotActive("assets/images/ticket.svg"),
            backgroundColor: Color(0xFF456189),


            icon: SvgPicture.asset(
              "assets/images/ticket.svg",
              height: 29,
              width: 29,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: _dotActive("assets/images/Account.svg"),
            backgroundColor: Color(0xFF456189),


            icon: SvgPicture.asset(
              "assets/images/Account.svg",
              height: 29,
              width: 29,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: _dotActive("assets/images/shuffle.svg"),
            backgroundColor: Color(0xFF456189),


            icon: SvgPicture.asset(
              "assets/images/shuffle.svg",
              height: 29,
              width: 29,
              color: Colors.white,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _dotActive(String urlImage) {
    return Column(
      children: [
        SvgPicture.asset(
          urlImage,
          height: 29,
          width: 29,
          color: Colors.white,
        ),
        Container(
          margin: EdgeInsets.only(top: 2),
          width: 8,
          height: 8,
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
      ],
    );
  }
}
