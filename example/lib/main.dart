import 'package:example/constants/colors.dart';
import 'package:example/constants/strings.dart';
import 'package:example/pages/grid_example.dart';
import 'package:example/pages/grid_with_scrollcontroller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.app_title,
      theme: ThemeData(primarySwatch: AppColors.primaryColor),
      home: MyHomePage(title: Strings.app_title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEEEE),
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
                      builder: (context) => GridExample(title: 'Grid Example'),
                    ),
                  );
                },
                child: Text('Grid Example'),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GridWithScrollControllerExample(
                          title: 'Grid + ScrollController'),
                    ),
                  );
                },
                child: Text('Grid With ScrollController Example'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
