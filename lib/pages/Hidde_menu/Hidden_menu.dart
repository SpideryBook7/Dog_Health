import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import '../Account_and_settings/Account_page.dart';
import '../Account_and_settings/settings_page.dart';
import '../Welcome_and_Nab_bar/navigation.dart';

class HiddenMenu extends StatefulWidget {
  const HiddenMenu({Key, key}) : super(key: key);

  @override
  State<HiddenMenu> createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Información',
          baseStyle: myTextStyle,
          selectedStyle: TextStyle(),
          colorLineSelected: Colors.deepPurple,
        ),
        MenuScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Account',
          baseStyle: myTextStyle,
          selectedStyle: TextStyle(),
          colorLineSelected: Colors.deepOrange,
        ),
        AccountPage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Settings',
          baseStyle: myTextStyle,
          selectedStyle: TextStyle(),
          colorLineSelected: Colors.blue,
        ),
        SettingsPage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.deepPurple.shade300,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 40,
      contentCornerRadius: 30,
    );
  }

  final myTextStyle = GoogleFonts.getFont(
    'Bebas Neue',
    fontWeight: FontWeight.bold,
    fontSize: 19,
    color: const Color.fromARGB(255, 255, 255, 255),
  );
}
