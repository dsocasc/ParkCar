import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkcar/main.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatelessWidget {

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
      home: const Map(title: 'AppParkCar'),
    );
  }

}

class Map extends StatefulWidget {

  const Map({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => NewMap();


}

class NewMap extends State<Map> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('MAPA'),
          //title: Text(widget.title),
        ),

        body: FlutterMap(
          options: MapOptions(
            center: LatLng(43.3713500, -8.3960000),
            zoom: 14.5,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            ElevatedButton(
              child: const Text('Go back'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: ''
              'call',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Calls',
          ),
          BottomNavigationBarItem(
    icon: Icon(Icons.chat),
    label: 'Calls',
    ),
    ],
    )
    ,
    );
  }

}