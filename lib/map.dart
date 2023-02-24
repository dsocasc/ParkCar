import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

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
    return FlutterMap(
      options: MapOptions(
        //center: LatLng(51.509364, -0.128928),
        zoom: 9.2,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
      ],
    );
  }

}