import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter CustomPaint Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var offset = [];

  @override
  void initState() {
    offset = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            offset.add(details.localPosition);
          });
        },
        onPanUpdate: (details) {
          setState(() {
            offset.add(details.localPosition);
          });
        },
        onPanEnd: (details) {
          setState(() {
            offset.add(null);
          });
        },
        child: Center(
            child: CustomPaint(
          painter: Painter(offset),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: Colors.red[50],
          ),
        )),
      ),
    );
  }
}

class Painter extends CustomPainter {
  final List<dynamic> offsets;

  Painter(this.offsets);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6.0;
    for (var i = 0; i < offsets.length - 1; i++) {
      if (offsets[i] != null && offsets[i + 1] != null) {
        canvas.drawLine(
          offsets[i],
          offsets[i + 1],
          paint,
        );
      } else if (offsets[i] != null && offsets[i + 1] == null) {
        canvas.drawPoints(
          PointMode.points,
          [offsets[i]],
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
