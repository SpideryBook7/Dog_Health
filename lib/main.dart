import 'dart:async';

import 'package:dog_health/components/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAppWithDelayedNavigation(
        child: MainPage(),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 70, 187, 233),
        ),
      ),
    );
  }
}

class MyAppWrapper extends StatelessWidget {
  final Widget child;

  const MyAppWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (FocusManager.instance.primaryFocus?.hasFocus ?? false) {
          FocusScope.of(context).unfocus();
          await Future.delayed(Duration(milliseconds: 300));
          return false;
        }
        return true;
      },
      child: child,
    );
  }
}

class MyAppWithDelayedNavigation extends StatefulWidget {
  final Widget child;

  const MyAppWithDelayedNavigation({Key? key, required this.child}) : super(key: key);

  @override
  _MyAppWithDelayedNavigationState createState() => _MyAppWithDelayedNavigationState();
}

class _MyAppWithDelayedNavigationState extends State<MyAppWithDelayedNavigation> {
  bool _allowNavigation = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Builder(
        builder: (BuildContext context) {
          return AbsorbPointer(
            absorbing: !_allowNavigation,
            child: widget.child,
          );
        },
      ),
    );
  }

  void delayNavigation() {
    setState(() {
      _allowNavigation = false;
    });
    Timer(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _allowNavigation = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      FocusManager.instance.addListener(_onFocusChange);
    });
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    if (!(FocusManager.instance.primaryFocus?.hasFocus ?? false)) {
      delayNavigation();
    }
  }
}
