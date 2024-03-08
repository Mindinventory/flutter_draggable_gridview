import 'package:example/pages/grid_example.dart';
import 'package:example/pages/grid_with_scrollcontroller.dart';
import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'constants/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appTitle,
      theme: ThemeData(primarySwatch: AppColors.primaryColor),
      home: const MyHomePage(title: Strings.appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEEEE),
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const GridExample(title: 'Grid Example')),
                  );
                },
                child: const Text('Grid Example'),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GridWithScrollControllerExample(
                              title: 'Grid + ScrollController'),
                    ),
                  );
                },
                child: const Text('Grid With ScrollController Example'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
