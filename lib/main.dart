import 'package:app/video_page/video.dart';
import 'package:flutter/material.dart';

import 'editor_page/editor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/editor': (context) => EditorPage(),
        '/video': (context) => VideoView()
      },
      home: MyHomePage(title: 'dabflip demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          TextButton(child: Text("editor"),onPressed: (){
            Navigator.pushNamed(context, '/editor');
          }),
          TextButton(child: Text("videoplayer"),onPressed: (){
             Navigator.pushNamed(context, '/video');
          })
        ],),
      ),
    );
  }
}
