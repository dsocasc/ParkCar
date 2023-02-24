import 'package:flutter/material.dart';

class MapPage extends StatelessWidget{

  const MapPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Map(title: 'ParkCar HomePage'),
    );
  }

}

class Map extends StatefulWidget{

  const Map ({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => NewMap();


}

class NewMap extends State<Map>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Text(
          'MAPA',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ],
    ),
    )
    );
  }

}